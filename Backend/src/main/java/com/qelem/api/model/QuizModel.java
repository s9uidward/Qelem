package com.qelem.api.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import lombok.Data;

@Data
@Entity
public class QuizModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @NotNull(message="Question field can't be null")
    @NotBlank(message="Question field can't be blank")
    private String question;
    @NotNull(message="Answer field can't be null")
    @NotBlank(message="Answer field can't be blank")
    private String answer;
}

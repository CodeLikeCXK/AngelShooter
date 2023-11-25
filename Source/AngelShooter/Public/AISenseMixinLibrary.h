// Fill out your copyright notice in the Description page of Project Settings.

#pragma once
#include "CoreMinimal.h"
#include "AIController.h"
#include "Perception/AISenseConfig_Hearing.h"
#include "Perception/AISenseConfig_Sight.h"
#include "Perception/AISense_Sight.h"
#include "UObject/NoExportTypes.h"
#include "AISenseMixinLibrary.generated.h"


UCLASS(Meta = (ScriptMixin = "AAIController"))
class UAISenseMixinLibrary : public UObject
{
	GENERATED_BODY()
public:
	UFUNCTION(ScriptCallable)
	static UAISenseConfig_Sight* AddSightConfig(AAIController* AIController)
	{
		TObjectPtr<class UAISenseConfig_Sight> SightConfig = AIController->CreateDefaultSubobject<UAISenseConfig_Sight>("SightConfig");
		return SightConfig;
	}

	UFUNCTION(ScriptCallable)
	static UAISenseConfig_Hearing* AddHearingConfig(AAIController* AIController)
	{
		TObjectPtr<class UAISenseConfig_Hearing> HearingConfig = AIController->CreateDefaultSubobject<UAISenseConfig_Hearing>("HearingConfig");
		return HearingConfig;
	}
};

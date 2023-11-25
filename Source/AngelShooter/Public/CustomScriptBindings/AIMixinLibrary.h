// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "AIController.h"
#include "Perception/AISenseConfig_Hearing.h"
#include "Perception/AISenseConfig_Sight.h"
#include "Perception/AISense_Sight.h"
#include "Runtime/AIModule/Classes/Perception/AIPerceptionComponent.h"
#include "Runtime/AIModule/Classes/Navigation/PathFollowingComponent.h"
#include "Runtime/AIModule/Classes/AItypes.h"
#include "UObject/NoExportTypes.h"
#include "AIMixinLibrary.generated.h"

/**
 * 
 */
UCLASS(Meta = (ScriptMixin = "UAIPerceptionComponent"))
class UAIMixinLibrary : public UObject
{
	GENERATED_BODY()
public:
	UFUNCTION(ScriptCallable)
	static void SetDominantSense(UAIPerceptionComponent* AIPerceptionComponent, TSubclassOf<UAISense> SenseClass)
	{
		AIPerceptionComponent->SetDominantSense(SenseClass);
	}
	UFUNCTION(ScriptCallable)
	static void ConfigureSense(UAIPerceptionComponent* AIPerceptionComponent, UAISenseConfig* SenseConfig)
	{
		AIPerceptionComponent->ConfigureSense(*SenseConfig);
	}

};



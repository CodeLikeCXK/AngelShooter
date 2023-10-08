// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "AIController.h"
#include "Perception/AIPerceptionTypes.h" 
#include "BaseEnemySenseController.generated.h"

/**
 * 
 */
UCLASS(BlueprintType)
class ANGELSHOOTER_API ABaseEnemySenseController : public AAIController
{
	GENERATED_BODY()

public:
	ABaseEnemySenseController();

	UPROPERTY(VisibleAnywhere, BlueprintReadWrite, Category = AI)
	TObjectPtr<UAIPerceptionComponent> AIPerceptionComponent = nullptr;
	
	UPROPERTY(VisibleAnywhere, BlueprintReadWrite, Category = AI)
	TObjectPtr<class UAISenseConfig_Sight> AISenseConfigSight = nullptr;
	
	UPROPERTY(VisibleAnywhere, BlueprintReadWrite, Category = AI)
	TObjectPtr<class UAISenseConfig_Hearing> AISenseConfigHearing = nullptr;
	
};

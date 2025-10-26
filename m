Return-Path: <linux-api+bounces-5139-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B6DC0A6FA
	for <lists+linux-api@lfdr.de>; Sun, 26 Oct 2025 13:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24249189F78C
	for <lists+linux-api@lfdr.de>; Sun, 26 Oct 2025 12:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D152367AC;
	Sun, 26 Oct 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpI7gZPH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750BE7483
	for <linux-api@vger.kernel.org>; Sun, 26 Oct 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481679; cv=none; b=rs0KWCvPgFpR7aJKp3U/kmzZiM0jrjUAt9rcp0Yurrc/AVmFO5/k8dEMMf6pBsQYWbbJYA9s1FFGg0rKkkVdcYXhtQu9qXn+GLIq8X9TrGhlH+kboCqHkYg0qr2jWQFTChAbpD837G4Z/85dvfXfFnizE8FK7qnDfOnwhlKZL0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481679; c=relaxed/simple;
	bh=96xgEF/cDhtXAWfkTUNwDGMDjcisf5kN8St/i2PJMdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvicCqa1c05lRx/8ITLNicPNv9f6aOp7Ghg++iz4pTrj/iwAOe8bfMJVt9mo4chtcG6sUPxDrqtgcV+xH5pEVuOHvE9jvPcp0XxHpFuKZx/KB+udURZXtJ5ZP+ph+gjfrRd2AWyNEvHV40mqWh2qKMqWfnacGtCDXI2xfvcP1Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpI7gZPH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so6480510a12.1
        for <linux-api@vger.kernel.org>; Sun, 26 Oct 2025 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761481677; x=1762086477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIyo2FXSI9SPMUW3EpKSAUcsK0v7MMc631sMa+neJaU=;
        b=mpI7gZPHdQ8TTyod60+eGIxcs/iWH3jWkmzTxX+jc8uNfd6EBHLpnWAH6Y6CeStdPH
         Fn5IVLPB7bQ2JbUn3kqErMQDlzAh/WAtSdYqOmqQWrG9LPitlSmghihc/KnVs9f1CKjH
         9kW8q7rgcAUhGxGixlfKPorsP0dWOzZw3pEy45tyYZW5r8HrfvUpp5u976f42RlQEp+o
         3x8sVDD/E5m5sGGuQL91ozMQ+MnYMc8pwkyhntxRk/wTc9LaBM3EsyMieHN5oYnOFGkh
         G+2iDdYQG58kgaE+bd/HRL97opcdxSbkW4qRFXUpPgXoS3mtdtj7RTpy7VIs8UyqzbIH
         oyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761481677; x=1762086477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIyo2FXSI9SPMUW3EpKSAUcsK0v7MMc631sMa+neJaU=;
        b=MWcXb0SfBgEMMH5TtSgXALKMQYcrLy0aMTQgjeInecBp6uqAO6uZ9vGcbKe3sEM7+4
         ae8CuEU2n98wIAUlh4LNq8+3thyFIhP3gkIpUO3aUfaHrYNwm6mZANSDw6USKwglspGm
         VhnBV04l6yT3b2hR6pRpxivk9mjNSVe1yZ53c6bJHBzFXRvGWI2/+vBThShSJs4J6Ee9
         qBbgiZmkHacr+UJllnxW0kQsRMhYA9r1eFYGILRPJCl6coFqFvF+nNgx3iuQxMWCUQQN
         SP9wLb4dHyFRpCKrs48s5W01t04U8pD0Hjv4NmKVqYbjVzUQjjudzjUMpipp5ztGjqfZ
         aUpw==
X-Forwarded-Encrypted: i=1; AJvYcCWCqZcmzqq6vlR3xTbNDDFQ3ecawBS1TP3eg7WhBNrd7jjqQy7oI/em4ctsrIfawIAQYPNqpCTipxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfwZPJ7tYseJVxxK0CAW2SviHoVj1oLOMAiYqEjIA7T0TLuPs
	75HLe8RpWFsjUYf5yYrxp7LmXpGg2X6uFEB03ig4XjirfJNfc+++oAdj
X-Gm-Gg: ASbGncvwb+C5QH4nnhD4+qOnSuaTMacuhp6g5xFdDgWSXpgh+kiotXMOpqFsGBfFE7p
	kunsJzq0K3xmYOSz4J9CHhrJvUvzqw0JDzjWQ+Ff2ekZQr0eb7MYl/Gy7hnGGmdnM/8+ugV4T3E
	FTqlG5KO0kb3qizZg98r6f7Ace4jWIZE5xGgZSJZjp9q8HcUAa9qKTt451f9PRxRb0MqNUMpopF
	Gz2lfTurSc5Ue8TGZMCyUlR6NHlisj3PNz0HmfcCXVdc4dyNArFILFXfmRk/0Om/PLgnkjiuPY9
	jaywkfZs0Qme7XcCROMKXkIEcdqaOe5Wluq3Job5t2rhB+SkATpGm4ZPZ5EwnEvEtD0UxiAugq6
	65wigjYP5a4yQzms2dKgrROK1EFESuRF/jqxVzLhqmc/gqaj6W58pt2yeZU1NP7XncoEIzm9JfT
	vNTRwuOoepmSPTa9OInWgyVg==
X-Google-Smtp-Source: AGHT+IG+nghLDB0dKUqOb9CoFdpZ3LvT3sjNG3elsEcJPMQmBpgpXzecd9vKXOr4yry1R2RtnfT9gg==
X-Received: by 2002:a05:6402:430e:b0:63c:b2:c656 with SMTP id 4fb4d7f45d1cf-63e6000378amr6445996a12.4.1761481676685;
        Sun, 26 Oct 2025 05:27:56 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-63e7ef6c13fsm3796082a12.7.2025.10.26.05.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 05:27:56 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: alx@kernel.org
Cc: brauner@kernel.org,
	cyphar@cyphar.com,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	safinaskar@zohomail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 0/8] man2: document "new" mount API
Date: Sun, 26 Oct 2025 15:27:42 +0300
Message-ID: <20251026122742.960661-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
References: <hk5kr2fbrpalyggobuz3zpqeekzqv7qlhfh6sjfifb6p5n5bjs@gjowkgi776ey>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alejandro Colomar <alx@kernel.org>:
> The full patch set has been merged now.  I've done a merge commit where

Alejandro, I still don't see manpages for "new" mount API here:
https://man7.org/linux/man-pages/dir_section_2.html

Please, publish.

-- 
Askar Safin


Return-Path: <linux-api+bounces-1151-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EBA87EAB6
	for <lists+linux-api@lfdr.de>; Mon, 18 Mar 2024 15:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767541C20E48
	for <lists+linux-api@lfdr.de>; Mon, 18 Mar 2024 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A54AEFB;
	Mon, 18 Mar 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jH2x7hOh"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637724E1C9
	for <linux-api@vger.kernel.org>; Mon, 18 Mar 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710771460; cv=none; b=Dn+Mhv1ZgsyJ9WtDPHYoVag9p/a4Tt/mSCUXmRGh/gC6/X/UQqaSeOvU01ygqqaHFPKtZXQ3KT7Bj/0f0WmUKSWtDOxr8UlIkek3ChnPPDW7t5FXrHrWZ6yjKa2dH49gWeEmIMvzk7u36b/V7Yo7MTxvnaiFHKBFJ4p4J4M3/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710771460; c=relaxed/simple;
	bh=SSX8AshGbr9nHSdd+rMiMjWER/SeBwHw0RUdG6rkgiY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qPqG/2fIhqdXzinzOH2+4yPIZApMyeR1nZOhRXNe1AT6zmVR0iSc1UDxW5jtiEWwSvaFiBMYAwKZizR6dYQ1TEgSz7m6Vn65syzppe32IBFQ2bf507NIOOoPFh90PNP8blLWTw2wf5p2c9Xv9p8C4DlSWOCwbtvieUjSzdxX9V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jH2x7hOh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a3c48e70fso47910047b3.1
        for <linux-api@vger.kernel.org>; Mon, 18 Mar 2024 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710771458; x=1711376258; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QRB/Uw2V4bbuzEvroXKLKUY4b1JDoPKkVy0P//4Wxg8=;
        b=jH2x7hOhpYfSofyIeHJot5glDiVykEKJaPH85cfKHNe5XMSEl5qu4bbVQa9Y4R0naK
         U2kb5owKwucgd+GxRErG54TT5gxeqb+H6S9UxdTYIxp4k59tjrGH7TCQ6xODpwrj8nIw
         bFUGSolVvMqRAOoYQQVg+mFgsA3vwYdZG7FVjJ4yp8cGPwJ2/+nsim1ja91eifiC7/By
         fxgG/8yUGT0QAMX1kmt7ejpiYqEatbY/97ppEpSbI+X/MVrB1CO2FG1jIOnjvJ/9dAgr
         Ugw10aeL4sa0JXBsfVz7cAiF0ohkGw7puHs1UlTBO+evHJ3woiu3U3iHVps8I2X5ozwK
         IN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710771458; x=1711376258;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRB/Uw2V4bbuzEvroXKLKUY4b1JDoPKkVy0P//4Wxg8=;
        b=JR7qvqdbDQUOi1zd0NL7PK1fC1vgTM55OTLsUATotuqh35PJQKiJ6hvnR5f66eZB3K
         mhu/bkc0c6zHCFNyGrHMpM6vrS2fssFhuX+/ueFZ+YomJIKURhIESEa+Q+j5oVHHW6ER
         9IkNSqPkV/7NlipO+Fhw7pSVpYekUx1ERPsy2jX7lPxX1JR2vwmkQDGc1F1Py6tJwl8F
         SrLMPwozrcEDq/8ezxibLbByquaZB89Wgr3Qt9q4bjCm9tYedtXAUVWoU/LLh5WjdIYp
         bysj1Gv/4n3t2odpytiVmNXXz9bnTESYCX+4o2U1MFpmWLGpLDI/1cgOw/Hxaf9LCIIE
         oLFA==
X-Gm-Message-State: AOJu0YzDVaUJru4nweYM59iRkSGPPvFi5u6H6Gowfn6G8TsYj4Zgg9o2
	y8gYR+00Amtl+cNQxJgZoDL6Wo320OARRsEbYGPh3gvoaSulFlTCdsNzMkTMP1If4CQx4T3Ibs8
	uDGoccIQ939AUHZM+Q51K0qjlhiiHUXHmWtkxmA==
X-Google-Smtp-Source: AGHT+IGTHPDaw4icWjEI4otP3WbTeNz5TOskxpocqs3cWJx+eOqwXhZxyKOmgcFmHf6UcbNHM6O3r1BdCUeAWUOUj/k=
X-Received: by 2002:a25:a189:0:b0:dcb:d8d1:2d59 with SMTP id
 a9-20020a25a189000000b00dcbd8d12d59mr9893392ybi.38.1710771458112; Mon, 18 Mar
 2024 07:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: qiqi tang <tangonepiece007@gmail.com>
Date: Mon, 18 Mar 2024 22:17:27 +0800
Message-ID: <CAPKn_0JW+KmggV899zEjY7vu54cgY246k7yTw++Wh8tkdZrx5A@mail.gmail.com>
Subject: Process synchronize with CAS
To: linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, everyone
     I am interested in the interface of linux. As we all know, there
is CAS way to accomplish the lockless ring buffer  with the kernel .
The kernel api can realize the datastruct Such as
__sync_fetch_and_add   type __sync_fetch_and_sub (type  * ptr, type
value, ...) and so on
But I find the limitation that this CAS  is work good for the  thread
model rather than Process model .  I want to create a shared Memory
and use mmap API  to mount this shared memory into  producter and
consumer process. What should I do to realize the synchronization
using the CAS algorithm . Are there have any API can over cross
Multi-Process just like the thread model? I would appreciate that
someone can provide the information for this email. Thank you!

Regards,
Jack


Return-Path: <linux-api+bounces-3953-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B755AE4352
	for <lists+linux-api@lfdr.de>; Mon, 23 Jun 2025 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E97497AAADD
	for <lists+linux-api@lfdr.de>; Mon, 23 Jun 2025 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6A8253F35;
	Mon, 23 Jun 2025 13:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z504OUye"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FDC24C060
	for <linux-api@vger.kernel.org>; Mon, 23 Jun 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685309; cv=none; b=NfsjHQA3HG13wczElLQt7OoFgs93/FHghEyDLLQ+yGUDJbCb+aEcRpMsG2kLlJF6oD7QHz2aS/MRsP0p44InLJeOfuUfwhG6UDYNM19VHvy6BgWUVMDaWjq91iJ0fUZgqO5G5UiW7enXtKtWOkq1Y0/GhtS3RFO9OZlsA+HGqcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685309; c=relaxed/simple;
	bh=M/05iL/gqplHdspF1H1P+EyauZRDiLKYUBnwAK+mrWw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MUQDQehAjAcQea9+IK0Idahbp77fOT4CJk+gNTrHfoS9Lu2OFC/RWTpQAGoFEYl3jQW64d8ZEpu7P5S+DTxF/PuokxlxQVoIYRJQcNxxP2TXtEIS8UNqjihfkcxTQXr+J/BBf1zvS6kGU9L50k8YkMvSTzysEwMIN2841RWWP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z504OUye; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f8fd1847so1422624f8f.1
        for <linux-api@vger.kernel.org>; Mon, 23 Jun 2025 06:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750685306; x=1751290106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/05iL/gqplHdspF1H1P+EyauZRDiLKYUBnwAK+mrWw=;
        b=Z504OUyeesIWnc8Gny2GsczXVc9BC+g794X6DDmp47t/GWOw08BgiVetVnfweHpRYk
         kBxzCwAwny3oWF0wRWf2Y/J5UHYxtelSm4Yz0s7kShTwPRARLESPdtd8mYMqThLaUJf4
         UsKgAHUmSjI4/sRH/x5aUpgFLhtg6s5ANmCCenEq/BG5WlBrcRlXuKxOcj6U/2rCvPQk
         a9jKMEEbFSOIIurSOLOJIwRUliCXGZf+7A8q7pgjj5cWQZ0d+aNaSfdAe1SMOnEvAtTr
         JShjjR+PVnwx+Vu2ocNWrTBSpPQcBGXFa4vtK6XOJBXhInMnrM+IgeSxNrrC9D8xPTV4
         emCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750685306; x=1751290106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/05iL/gqplHdspF1H1P+EyauZRDiLKYUBnwAK+mrWw=;
        b=eI7n1ovuH+UyyGN0+KKxBJCIXJ/OgHy62OEBtic5RqAriInvB6DI9fL0yaP4eU9nd/
         NG4NCsoNUOlJ7xEz6Er68cMQ2dcnkcL6iFlfo6eKlngDBWpT/Nifcl+/QVGAMPz+4eui
         gS2dcTMecmzWlvJKHk2HmvtxZmQQumo89yPeiZkyjfToOCQA2j/afMs4BcYmntvwgDhV
         S+fVFoHRQIhD4knNYTXlyL9NoyLJJAJMFu532eMNlmmnNdq1sHvoyIzxtQY/cMXDZRbC
         t/hM5jRMy1lTCMyh3NPHU8qpDL3m7kAWe8Su0ap1Fur+30NhKiHIgCMaoli8J/9IzFyn
         YI4w==
X-Forwarded-Encrypted: i=1; AJvYcCVV/f8JQEaRIWeLswoU3OmtB0pPIE43GtvYDmQ0dCZ8n/s7J/MX8c6m11SoksG79Kj0uusOfm5gwnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP1X2Yx2sOLCiT6LkCdDnc+D/pgT5iieGYs4Hj5ygHz2So/tkV
	5phM/LU8BvLGEWNb9l35ozevkaLEMDuto0nZFK/03/VXPatgKLONEiL8K2b/3KWR3lkiGhJf4Tp
	sQizfBYQ7TQ==
X-Google-Smtp-Source: AGHT+IEQemU9U1qSUFKz2+7itsR5jiBLvrwnJtII5ZYSZrfv9r4t0m/l4xKKQuRElhwXLh7ukcOz5A85xW+D
X-Received: from wrck9.prod.google.com ([2002:a5d:5249:0:b0:3a4:e841:e092])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1448:b0:3a5:25e0:1851
 with SMTP id ffacd0b85a97d-3a6d12fb2dfmr10350377f8f.7.1750685306572; Mon, 23
 Jun 2025 06:28:26 -0700 (PDT)
Date: Mon, 23 Jun 2025 15:28:03 +0200
In-Reply-To: <aFNYQkbEctT6N0Hb@lappy>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <aFNYQkbEctT6N0Hb@lappy>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250623132803.26760-1-dvyukov@google.com>
Subject: Re: [RFC 00/19] Kernel API Specification Framework
From: Dmitry Vyukov <dvyukov@google.com>
To: sashal@kernel.org
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tools@kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Nice!

A bag of assorted comments:

1. I share the same concern of duplicating info.
If there are lots of duplication it may lead to failure of the whole effort
since folks won't update these and/or they will get out of sync.
If a syscall arg is e.g. umode_t, we already know that it's an integer
of that enum type, and that it's an input arg.
In syzkaller we have a Clang-tool:
https://github.com/google/syzkaller/blob/master/tools/syz-declextract/clangtool/declextract.cpp
that extracts a bunch of interfaces automatically:
https://raw.githubusercontent.com/google/syzkaller/refs/heads/master/sys/linux/auto.txt
Though, oviously that won't have user-readable string descriptions, can't be used as a source
of truth, and may be challenging to integrate into kernel build process.
Though, extracting some of that info automatically may be nice.

2. Does this framework ensure that the specified info about args is correct?
E.g. number of syscall args, and their types match the actual ones?
If such things are not tested/validated during build, I afraid they will be
riddled with bugs over time.

3. To reduce duplication we could use more type information, e.g. I was always
frustrated that close is just:

SYSCALL_DEFINE1(close, unsigned int, fd)

whereas if we would do:

typedef int fd_t;
SYSCALL_DEFINE1(close, fd_t, fd)

then all semantic info about the arg is already in the code.

4. If we specify e.g. error return values here with descirptions,
can that be used as the source of truth to generate man pages?
That would eliminate some duplication.

5. We have a long standing dream that kernel developers add fuzzing descirpions
along with new kernel interfaces. So far we got very few contributions to syzkaller
from kernel developers. This framework can serve as the way to do it, which is nice.

6. What's the goal of validation of the input arguments?
Kernel code must do this validation anyway, right.
Any non-trivial validation is hard, e.g. even for open the validation function
for file name would need to have access to flags and check file precense for
some flags combinations. That may add significant amount of non-trivial code
that duplicates main syscall logic, and that logic may also have bugs and
memory leaks.

7. One of the most useful uses of this framework that I see if testing kernel
behavior correctness. I wonder what properties we can test with these descirptions,
and if we can add more useful info for that purpose.
Argument validation does not help here (it's userspace bugs at best).
Return values potentially may be useful, e.g. if we see a return value that's
not specified, potentially it's a kernel bug.
Side-effects specification potentially can be used to detect logical kernel bugs,
e.g. if a syscall does not claim to change fs state, but it does, it's a bug.
Though, a more useful check should be failure/concurrency atomicity.
Namely, if a syscall claims to not alter state on failure, it shouldn't do so.
Concurrency atomicity means linearizability of concurrent syscalls
(side-effects match one of 2 possible orders of syscalls).
But for these we would need to add additional flags to the descriptions
that say that a syscall supports failure/concurrency atomicity.

8. It would be useful to have a mapping of file_operations to actual files in fs.
Otherwise the exposed info is not very actionable, since there is no way to understand
what actual file/fd the ioctl's can be applied to.

9. I see that syscalls and ioctls say:
KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
Can't we make this implicit? Are there any other options?
Similarly an ioctl description says it releases a mutex (.released = true,),
all ioctls/syscalls must release all acquired mutexes, no?
Generally, the less verbose the descriptions are, the higher chances of their survival.
+Marco also works static compiler-enforced lock checking annotations,
I wonder if they can be used to describe this in a more useful way.





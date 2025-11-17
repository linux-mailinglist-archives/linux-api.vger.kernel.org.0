Return-Path: <linux-api+bounces-5337-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 38111C65FE9
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 20:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D83213512B0
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 19:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF83126B3;
	Mon, 17 Nov 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qDvuwokg"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA22FF66C
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763408352; cv=none; b=BQeoxYqiPmJWPei0aBD1MR9ie0qJY6Y+AQFD9tJdXmSpJbLL7YH0yt9tzT+ngxdtTS2lU8G/YjbzbsMu4pNiXJBiHOAvG7q3w5c9yHSj9VkKku4x1JXIapTMyd2q4J2sibkQWul45jmtrg2ntvO3WA8wzd141nqKGp1T9g6rACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763408352; c=relaxed/simple;
	bh=b9aPjw2LvCUZNOTxP5qpY7NgJ724vIXmAiSxxWNqFj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+yCjJ+QaLfFKebMqkXfLuJ0f252+OSARnZVtYusT6USbU2Lys8LWEAjNNQiK1j/blAiaKFrUecxg43DiHQeXGvZXUn1ZVG0XLBG08Qm7y6bD7yslhA1cXYAkwvUYpsRlLt/Lk4OHiYcuTLQR9+2wCFR0TFRH75Yk8UqWVT1moI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qDvuwokg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5957f617ff0so5383445e87.2
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 11:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763408348; x=1764013148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9aPjw2LvCUZNOTxP5qpY7NgJ724vIXmAiSxxWNqFj0=;
        b=qDvuwokgJ7ynZsglDSewTnrj0tY7az0tYREPbz/DYRBG3kgll4ay88TKYpt702LNbv
         2uu9HxCqV8Gtaa7IeX+TQ/7IJESYmIpflDbL3EdzIQstkzb7uLuedxhd6H0MIOZtpCNf
         dqCAh5kzyBQVFdKgszhSQLcNB/fBGs0dF9ZkLt+IN7ivHw7Pyb1nDcrfQCc9aOPxxtzV
         XgxEatw7hijzxySZsCeRTfqro9vgiRYPuGh57NSKzxa8kYs0rH8QCkLdlM2onOxtxFQi
         YaWiyQoCDCgle5arO0Y1VMZHQHLLW4qL3BV6ZhdKNNdTMBhUhuRCfIAi4Wofq9LoYO9f
         hkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763408348; x=1764013148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b9aPjw2LvCUZNOTxP5qpY7NgJ724vIXmAiSxxWNqFj0=;
        b=wdcJN1aKEWOP3VEutn3XB7KhthoVXwBBa/mpoij0Y3M3JVSIKbd7nsT4aRjPGvHk2o
         +WP+Y2Qyaw/h+ZZNXCnlcUVFqqgDy2lCN3Qlz3k4QmcH3+EpzJeDsZnqDg7keZ7tOlSX
         jh659NwQ7P0tMtcjYxaRc0Xh0uGiaa7dJByCCnTJknfjuG/b8v4siLAPaWZQPsO+5LfI
         0j///7fMBLs+kiEEBJwbQaFVaXDe2OMcl4m4CVzxa1EC9qDumAZVADlQL6NTBnnfoW45
         kkHUMB71HJYp0gkL0oowRR+Di8wFEW8wvibUCU6Kzs32kRMOesPC4e83Auvl9Ma1VO8C
         E/mg==
X-Forwarded-Encrypted: i=1; AJvYcCVwH0pPPSSUZrphwKCXJOZECi4H8HHWbn3EKfAMbrgTd+nZiuq7Cwqk9TblKQ4nxIb/5a6ndy4sEXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaU5LKR2Z4x0Og9QNaT+yywqTPsDYiA5EONEOvbrwUADFnNaTa
	+O1GwBusSTI+pIIdKgrqgAYd81J1h4lLF3iJwTnhaF88n7rWY65Hlnn+9Av3uoN6g0GcMxfR6Aq
	K6eOj7LMumNn0Hq/CjqaglmhcfKeoTgcf7iYwbiw8
X-Gm-Gg: ASbGnctlcppKM8fH3GQWqueNkr3Cs3BVluDbNDsKQLMRXCQ/+Ye87TTZQmnSnK3ghQm
	GmUAromhS8jjk0Xzv0IJ/t56TsuXShw9HNeiQ/JbcmPEyeHM15C/KiZZnXlGeTn6BRz8O0eCiuk
	3QBUdgxVJ7Rr6nC5RDvIIVoA/P+7CrXrzQpkDcJA/6ZJdGZyoanql4iail7dyzFCfZ+IFrTorKa
	l+KCCNz3ms/JRzvIof3HM/i9D+V8oTJIxZEeaxRTtIGZWDUGW6ZBcsQyL2QSPBDOMpI6oA=
X-Google-Smtp-Source: AGHT+IFN4xOyb2ZHLHkpG4LWQorQPgUWti/L9wSnM39BaS2Jya2ibJD/Dhx+BTWb3SDVgOFhixbcdjfh2auRRViLmWg=
X-Received: by 2002:a05:6512:12c9:b0:594:3270:3b14 with SMTP id
 2adb3069b0e04-595841f96b2mr4673200e87.32.1763408347863; Mon, 17 Nov 2025
 11:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com> <20251115233409.768044-18-pasha.tatashin@soleen.com>
In-Reply-To: <20251115233409.768044-18-pasha.tatashin@soleen.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 17 Nov 2025 11:38:40 -0800
X-Gm-Features: AWmQ_blJn1ck9PTGxHP2-KznbYK2P4A6YYPNkQIgUM3c99KDsjZHm2bxwWZBfno
Message-ID: <CALzav=eskApQk6kstsQWThwV=h4Qmd85kAw3CxZt=6hj=JS-Xw@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] selftests/liveupdate: Add userspace API selftests
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, rppt@kernel.org, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, gregkh@linuxfoundation.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, rafael@kernel.org, 
	dakr@kernel.org, bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 3:34=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:

> diff --git a/tools/testing/selftests/liveupdate/.gitignore b/tools/testin=
g/selftests/liveupdate/.gitignore
> new file mode 100644
> index 000000000000..af6e773cf98f
> --- /dev/null
> +++ b/tools/testing/selftests/liveupdate/.gitignore
> @@ -0,0 +1 @@
> +/liveupdate

I would recommend the following .gitignore so you don't have to keep
updating it every time there's a new executable or other build
artifact. This is what we use in the KVM and VFIO selftests.

# SPDX-License-Identifier: GPL-2.0-only
*
!/**/
!*.c
!*.h
!*.S
!*.sh
!*.mk
!.gitignore
!config
!Makefile


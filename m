Return-Path: <linux-api+bounces-1513-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D874F8C5ED9
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2024 03:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE71C20DF9
	for <lists+linux-api@lfdr.de>; Wed, 15 May 2024 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DBC1109;
	Wed, 15 May 2024 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aLO7PNM0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91646BA34
	for <linux-api@vger.kernel.org>; Wed, 15 May 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715737479; cv=none; b=Kcl+sYsHSnHjTXldrKq5IOjhpXvdEH8GN/aszNHnFum5AB/gLJA+YyAx2S3D9NnNhXWKWqjPIVw1ayylK+T2gHFTXKfyUwgCdI9cfJXwATP9GdM1niEm18o9zrbpIT+wPSYTiRW0KF/CS8Y8qaxqwUwEowjLqEtNCznqXqWmmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715737479; c=relaxed/simple;
	bh=utrhsUe7+CsXJr0wIMC6o0BnlW4BggIXELMhPPq0LLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NM4yuzAqqrGO/TMD6MnuvyJGFHobCLg5yO0ATCbiAhERaMr32nCALwuDqrSnXvf4OeNT/HvHXyleD4okiEAlr8rJR2GdUseKXLl4tnweWkUh9ifLLmtwRkKUqu/rn+nz5PzRGygjj0SJaG5VE/mNvhDLHtj/TjzB8UzSj14dnAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aLO7PNM0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f4521ad6c0so5156553b3a.0
        for <linux-api@vger.kernel.org>; Tue, 14 May 2024 18:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715737477; x=1716342277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qo/v4eXzdi6YHioqLixe5DcUJ4f/UL2pWmemFFHuCb4=;
        b=aLO7PNM0dUV2nFR3uNW7VBuUROhMzuknk95TAq+VncPVvq/8XGJREw03E/f7db/T7P
         56TlB3Y+EGMHqsw4i6PxJd2oJbmp3tufIJwWylFjTESpM6nssCbCe2AUrJ3mpZ+yV/NX
         N9naksMPBnPJ1NzvWgOFG1s0h9vjjWE6IbdAm8HcnaCnB6/UzZe6huAKXDMXIe3jbRqy
         /dRy+gmrTNNhM3JOYLjGSKz+93l7oovuD6dSDlB2Obx3tJTrf8mtA4/2Ar1M9qR4NlIU
         LYRQrhyGomg8fkgEIUixYtYbj+c+Pvct6Td4XtuUUHhF/blPWTtgqAzfSgfD6ErKZ5+z
         CYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715737477; x=1716342277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qo/v4eXzdi6YHioqLixe5DcUJ4f/UL2pWmemFFHuCb4=;
        b=ZedsbQnwWYfkkEp7yzSPh/Yzgw+qujtR0mEFcAAMJFSVvWqC5GhAeN626xjxa0TRKW
         86a+xTuC/q7Z9XRoCaiyQw9kaqWpU6UtWpPMWPHkWwsMOi3d8d1u2oLmfk4W9pBYJXPN
         7UOCQSQToRfFoELK+m58rQIGdNSqySO5w7grCia5uNXn45LUnVm5DfMhkH+nZ0tfEj7E
         2vVyy04GgP3d51jnY7BxYSYXwRH05yvRsgwdRSSjs2oz7sKw3qamz5BAjzp+Uvzv4ZX1
         qMUhNPhKYQ/ovS1T+Nzgqg/tccOhSDRDgMlzjbnfOASGGWdah/sm/kwXP+5XpBlyQHp2
         NFPw==
X-Forwarded-Encrypted: i=1; AJvYcCWBsPOshyyesZd750MHfV4BUsvxUW6AYuScvO0LCDPPN6v9fF24DudqhiTX0LPx4pCuNL2f10rP4IE0Ao+Ghn1owpHwXHH8F7E6
X-Gm-Message-State: AOJu0YyfUVVtEvyQrw1O5TWnrBFLRS95LaN7SOLeqTznVyLxF3Q7yUkW
	lvOHZWiWADfuGWkK7ognuRPKR8xUFKAh1n4SKnvo8bYr6pOfHpJxv+goHT29sYw=
X-Google-Smtp-Source: AGHT+IEHwYi3lxbkeeQme7XFurOrb4+25P1XQTNA/EpQWyQ7HAW2wUw7KzjFUtiLX1yfPtkTtjx+Lw==
X-Received: by 2002:a05:6a00:1493:b0:6ea:df6a:39e7 with SMTP id d2e1a72fcca58-6f4e02adb85mr16427939b3a.13.1715737476914;
        Tue, 14 May 2024 18:44:36 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-634103f6e2dsm8832789a12.61.2024.05.14.18.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 18:44:36 -0700 (PDT)
Date: Tue, 14 May 2024 18:44:33 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>, "yhs@fb.com" <yhs@fb.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv5 bpf-next 6/8] x86/shstk: Add return uprobe support
Message-ID: <ZkQTgQ3aKU4MAjPu@debug.ba.rivosinc.com>
References: <20240507105321.71524-1-jolsa@kernel.org>
 <20240507105321.71524-7-jolsa@kernel.org>
 <a08a955c74682e9dc6eb6d49b91c6968c9b62f75.camel@intel.com>
 <ZjyJsl_u_FmYHrki@krava>
 <a8b7be15e6dbb1e8f2acaee7dae21fec7775194c.camel@intel.com>
 <Zj_enIB_J6pGJ6Nu@krava>
 <20240513185040.416d62bc4a71e79367c1cd9c@kernel.org>
 <c56ae75e9cf0878ac46185a14a18f6ff7e8f891a.camel@intel.com>
 <ZkKE3qT1X_Jirb92@krava>
 <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e15152888d543d2ee4e5a1d75298c80aa946659.camel@intel.com>

On Wed, May 15, 2024 at 01:10:03AM +0000, Edgecombe, Rick P wrote:
>On Mon, 2024-05-13 at 15:23 -0600, Jiri Olsa wrote:
>> so at the moment the patch 6 changes shadow stack for
>>
>> 1) current uretprobe which are not working at the moment and we change
>>    the top value of shadow stack with shstk_push_frame
>> 2) optimized uretprobe which needs to push new frame on shadow stack
>>    with shstk_update_last_frame
>>
>> I think we should do 1) and have current uretprobe working with shadow
>> stack, which is broken at the moment
>>
>> I'm ok with not using optimized uretprobe when shadow stack is detected
>> as enabled and we go with current uretprobe in that case
>>
>> would this work for you?
>
>Sorry for the delay. It seems reasonable to me due to 1 being at a fixed address
>where 2 was arbitrary address. But Peterz might have felt the opposite earlier.
>Not sure.
>
>I'd also love to get some second opinions from broonie (arm shadow stack) and
>Deepak (riscv shadow stack).
>
>Deepak, even if riscv has a special instruction that pushes to the shadow stack,
>will it be ok if there is a callable operation that does the same thing? Like,
>aren't you relying on endbranches or the compiler or something such that
>arbitrary data can't be pushed via that instruction?

Instruction is `sspush x1/ra`. It pushes contents of register return address (ra 
also called x1) onto shadow stack. `ra` is like arm's equivalent of link register.
Prologue of function is supposed to have `sspush x1` to save it away.
ISA doesn't allow encodings with register in risc-v GPRs (except register x5
because some embedded riscv space toolchains have used x5 as ra too).

On question of callable operation, I think still need to fully understand who manages
the probe and forward progress.

Question,

Is it kernel who is maintaining all return probes, meaning original return addresses
are saved in kernel data structures on per task basis. Once uretprobe did its job then
its kernel who is ensuring return to original return address ?

>
>BTW Jiri, thanks for considering shadow stack in your work.


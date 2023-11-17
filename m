Return-Path: <linux-api+bounces-86-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E77EF948
	for <lists+linux-api@lfdr.de>; Fri, 17 Nov 2023 22:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38CD1C20952
	for <lists+linux-api@lfdr.de>; Fri, 17 Nov 2023 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5184642D;
	Fri, 17 Nov 2023 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jeghf2rJ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD2D5B
	for <linux-api@vger.kernel.org>; Fri, 17 Nov 2023 13:13:08 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b2e72fe47fso1551610b6e.1
        for <linux-api@vger.kernel.org>; Fri, 17 Nov 2023 13:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1700255588; x=1700860388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PKz01wcVX8Bxs3KR+NJBt3hwfdvhmPYzaTZtcibwsZc=;
        b=jeghf2rJzclJzmiMiYweFiK2yBMmI83nH0JL+BaLEEjrzuMR8gAVxET00ZfzKhjfG4
         EN0iZiMHgHaSkHFd/odjJYM3/s93jrJQVwfUW3IO3Y0quEWdKtWPtSWDAIEZvERGq5vo
         TVGfwmg7JChgq8xrfcqmA8bZ0Ae7kT/x9I7ass/3h3V5IhT1F3lVw++7cEC4X++P1JWd
         uU+gCH+MTYePUFhRppVYHN+wFC0sLPEJmMWINoaex8sYl3R+xiyZkQ4K+vtVU5yAQZte
         x+yVLwgQ6ClbRJ2ym8zSxUcsH17Acv60AH24H8CfvGCizvKnOzLjlNFApubFFMfKnE4x
         jr1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700255588; x=1700860388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKz01wcVX8Bxs3KR+NJBt3hwfdvhmPYzaTZtcibwsZc=;
        b=fV/LrjMe4EInxmxpESFBSQnCBIu80zrj1DIldw5YxN3XuR7A2cmdnrROn6fHbWOoxp
         jxxiIUBoIdLLMqhKX1VVMmGYtmxtTFYKLemz0/JSzhjik9DULCv8dH6A7JqEf54LOOkQ
         sB+5jwBqHqxPjigbYO6et3V2Y8OL8FQKD6fm3qlDG+CiYzytGZ6bxPSyFL2DBDy6cLkm
         FcN3BhaDNU/PEb8dvuJ0b38S99LeX45XY6+oxljXv5S77NNtuFLooo3vZM9erGXH53cf
         8WzZAePqqdBad5Lz3KsjaKJw/hf+9pASvU0jd0OvNEVm7oexmRNG73DNI85J/SXiOFzU
         GR5Q==
X-Gm-Message-State: AOJu0YyVSdschWsHCX3b8R7dvCyJMw+u8eqcdex3OFSqhvGXorm+Hxbp
	jTajc5Rg3H8OBEm+Rs8Le6E6CQ==
X-Google-Smtp-Source: AGHT+IHkJxAw4BCtYb7vtqTpvYzYdZ/WV9j6uSsTfqp9w+14kwuRXNQnpMN39mmIJPuH7mhfyy/qGA==
X-Received: by 2002:a05:6808:429a:b0:3b2:e2d1:34d2 with SMTP id dq26-20020a056808429a00b003b2e2d134d2mr516718oib.47.1700255587791;
        Fri, 17 Nov 2023 13:13:07 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id o18-20020a05680803d200b003ae425fc9bdsm408308oie.23.2023.11.17.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 13:12:53 -0800 (PST)
Date: Fri, 17 Nov 2023 13:12:46 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"mgorman@suse.de" <mgorman@suse.de>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"vschneid@redhat.com" <vschneid@redhat.com>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"bristot@redhat.com" <bristot@redhat.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bsegall@google.com" <bsegall@google.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"jannh@google.com" <jannh@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"Pandey, Sunil K" <sunil.k.pandey@intel.com>
Subject: Re: [PATCH RFC RFT v2 5/5] kselftest/clone3: Test shadow stack
 support
Message-ID: <ZVfXTmVestrAwIkN@debug.ba.rivosinc.com>
References: <20231114-clone3-shadow-stack-v2-0-b613f8681155@kernel.org>
 <20231114-clone3-shadow-stack-v2-5-b613f8681155@kernel.org>
 <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <309927ad8bfa72ce2d084ee16cd0cd84e69fef16.camel@intel.com>

On Tue, Nov 14, 2023 at 11:11:58PM +0000, Edgecombe, Rick P wrote:
>On Tue, 2023-11-14 at 20:05 +0000, Mark Brown wrote:
>> +static void test_shadow_stack_supported(void)
>> +{
>> +        long shadow_stack;
>> +
>> +       shadow_stack = syscall(__NR_map_shadow_stack, 0,
>> getpagesize(), 0);
>
>Hmm, x86 fails this call if user shadow stack is not supported in the
>HW or the kernel, but doesn't care if it is enabled on the thread or
>not. If shadow stack is not enabled (or not yet enabled), shadow stacks
>are allowed to be mapped. Should it fail if shadow stack is not yet
>enabled?
>
>Since shadow stack is per thread, map_shadow_stack could still be
>called on another thread that has it enabled. Basically I don't think
>blocking it will reduce the possible states the kernel has to handle.
>
>The traditional way to check if shadow stack is enabled on x86 is the
>check for a non zero return from the _get_ssp() intrinsic:
>https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/x86-control-flow-protection-intrinsics.html
>
>It seems like there will be a need for some generic method of checking
>if shadow stack is enabled. Maybe a more generic compiler
>intrinsic/builtin or glibc API (something unrelated to SSP)?

Exposing a new file under procfs would be useful?
Something like "/proc/sys/vm/user_shadow_stack_supported"

`map_shadow_stack` can return MAP_FAILED for other reasons.
I think `kselftests` are fine but I don't want people to pick up this
as test code and run with it in production :-)

So kernel providing a way to indicate whether it supports shadow stack
mappings in user mode via procfs would be useful and arch agnostic.

>
>> +       {
>> +               .name = "Shadow stack on system with shadow stack",
>> +               .flags = 0,
>> +               .size = 0,
>> +               .expected = 0,
>> +               .e2big_valid = true,
>> +               .test_mode = CLONE3_ARGS_SHADOW_STACK,
>> +               .filter = no_shadow_stack,
>> +       },
>> +       {
>> +               .name = "Shadow stack on system without shadow
>> stack",
>> +               .flags = 0,
>> +               .size = 0,
>> +               .expected = -EINVAL,
>> +               .e2big_valid = true,
>> +               .test_mode = CLONE3_ARGS_SHADOW_STACK,
>> +               .filter = have_shadow_stack,
>> +       },
>>  };
>>  
>I changed x86's map_shadow_stack to return an error when shadow stack
>was not enabled to make the detection logic in the test work. Also
>changed the clone3 Makefile to generate the shadow stack bit in the
>tests. When running the 'clone3' test with shadow stack it passed, but
>there is a failure in the non-shadow stack case:
>...
># Shadow stack not supported
>ok 20 # SKIP Shadow stack on system with shadow stack
># Running test 'Shadow stack on system without shadow stack'
># [1333] Trying clone3() with flags 0 (size 0)
># I am the parent (1333). My child's pid is 1342
># I am the child, my PID is 1342
># [1333] clone3() with flags says: 0 expected -22
># [1333] Result (0) is different than expected (-22)
>not ok 21 Shadow stack on system without shadow stack
># Totals: pass:19 fail:1 xfail:0 xpass:0 skip:1 error:0
>
>The other tests passed in both cases. I'm going to dig into the other
>parts now but can circle back if it's not obvious what's going on
>there.


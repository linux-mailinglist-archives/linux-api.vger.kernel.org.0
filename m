Return-Path: <linux-api+bounces-1471-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99438BB7D4
	for <lists+linux-api@lfdr.de>; Sat,  4 May 2024 01:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647011F23445
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2024 23:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D012282492;
	Fri,  3 May 2024 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zCe+/lF3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B458ABC
	for <linux-api@vger.kernel.org>; Fri,  3 May 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777318; cv=none; b=Fiil8pfD51dIcGcj7TJ7DEvjoM54Pd3yX/aH729sA7Lnu1SI8MsrLdzM8agREHSxtgoA9y7fRP+GDoftda1tFfBDyKz+N7Lh9uEPzybVPq/wq4QsCKYxfQ1sUj0mc1C0Zybn8oQ6DiAJUs6RmX4k4/W+vMOzC3PUJgmtKi0DMkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777318; c=relaxed/simple;
	bh=4+92T3dF1pCkzFJyIvWH9pdOMABziRyYEtERHQRUflQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SptrdcLP1ianSj5OSeA2qVp9QmW0rU8nd1afDbasbLg2aDXLer0EsomrVzF7a9LyQx26Awgg3zhXFqpN7mEP34wvKmmn2ne0DutrhMyxtlTh7yJ27PrvPnYdYObFAa5oz8ZKhoo3TBtH+kKErQOYE8Fuqz+lIPr+xFumPF8y7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zCe+/lF3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1ecddf96313so1488445ad.2
        for <linux-api@vger.kernel.org>; Fri, 03 May 2024 16:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1714777317; x=1715382117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+92T3dF1pCkzFJyIvWH9pdOMABziRyYEtERHQRUflQ=;
        b=zCe+/lF34YSpkLm2TxtBbKSM5HvQTiKwAV3/44wZGfe5OEzwrVa15OMDxIqPZ6I5Ir
         fuY3gGUb1FAi2faOv0IGo2pG5+C0IrtWoAvDo27Rm59TDonSdrohlP/jS86LM+nBFEtr
         GQ3wWvTpg2+gE2rC84ee/b9iJ/8BqenQTpLVlydzmF1Q0OR+SG+iFBTc7vA2g6AR9wul
         m/yFYwnkqQjsc8A+msgyA4Sd2DrAZoqHoiIs/JMbDHBl0iLiHDMXXc9ty8yA5mVjjUPu
         NIXwFUvpRU7gKebDzlcSK+ISTKqFUA3d5KvW+ehUNElxgrnfJxbe9q+O7QQnllgNc6za
         k4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714777317; x=1715382117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+92T3dF1pCkzFJyIvWH9pdOMABziRyYEtERHQRUflQ=;
        b=mNUTMG5TMYL6QhGzFBb8hkTzpULvvoNvny6/pPYZ8bNeZHMyHvECnqfreGU5vhc2aZ
         2H2NmRFfvH8WpQ3U8eGgzR02fJMghOyQyaG3xgNZferBytBCD19qSkCgHVkLkpSOaKiw
         3Q1pdQxKymR3QFKPATqwArvNKLSOY9EcuW2G2fmvWSchAqRmx5M/iiofz1Xif6ZgYzWN
         0xTsWjtO5pM4C/rXvpow9uF8cvpwitOw9V0ZN97a76HUptRXiFIrBpc+AgHuJggUlmdA
         jQ9S11bFhswXUzq7ItFHuatGL02zo5At/hMaxdtMGM7dzpNNHTzSA0BiH/6AeqdYwU2F
         3wTw==
X-Forwarded-Encrypted: i=1; AJvYcCXK6a0bUdO/bt28Ge+raQSOm8VV3NFwWY429Oe0RDBjOCrdlzC2ISnfscunSvZ5d1eW6VuxB4CUG4ph2rLfxRTHU/ZMAtrQ0IiW
X-Gm-Message-State: AOJu0YzhvP/TaOvIs/BXiaIywx+Uvj0CAav6+QgV74Oq6DckPuelmu72
	P3jjkOdTLR+TD5+ifPwfudZssry8fyTabvUg8aSQvG9f9q4UoawzNj4dUapYD+g=
X-Google-Smtp-Source: AGHT+IHzq6AzE/NVvcqxm4ol0K1axCLWE5IjNbsp5PyIHu/cbS2sPY/kkICJk49x3bkJcMIgzsAwYg==
X-Received: by 2002:a17:903:32cf:b0:1e2:ca65:68c2 with SMTP id i15-20020a17090332cf00b001e2ca6568c2mr5565119plr.51.1714777316672;
        Fri, 03 May 2024 16:01:56 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902684700b001eab1a1a752sm3841345pln.120.2024.05.03.16.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 16:01:56 -0700 (PDT)
Date: Fri, 3 May 2024 16:01:53 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCHv4 bpf-next 2/7] uprobe: Add uretprobe syscall to speed up
 return probe
Message-ID: <ZjVs4bxi7CpWhtEQ@debug.ba.rivosinc.com>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <20240502122313.1579719-3-jolsa@kernel.org>
 <20240503113453.GK40213@noisy.programming.kicks-ass.net>
 <ZjTg2cunShA6VbpY@krava>
 <725e2000dc56d55da4097cface4109c17fe5ad1a.camel@intel.com>
 <ZjU4ganRF1Cbiug6@krava>
 <6c143c648e2eff6c4d4b5e4700d1a8fbcc0f8cbc.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6c143c648e2eff6c4d4b5e4700d1a8fbcc0f8cbc.camel@intel.com>

On Fri, May 03, 2024 at 07:38:18PM +0000, Edgecombe, Rick P wrote:
>+Some more shadow stack folks from other archs. We are discussing how uretprobes
>work with shadow stack.
>
>Context:
>https://lore.kernel.org/lkml/ZjU4ganRF1Cbiug6@krava/

Thanks Rick.

Yeah I didn't give enough attention to uprobes either.
Although now that I think for RISC-V shadow stack, it shouldn't be an issue.
On RISC-V return addresses don't get pushed as part of call instruction.
There is a distinct instruction "shadow stack push of return address" in prolog.
Similarly in epilog there is distinct instruction "shadow stack pop and check with
link register".

On RISC-V, uretprobe would install a uprobe on function start and when it's hit.
It'll replace pt_regs->ra = trampoline_handler. As function will resume, trampoline
addr will get pushed and popped. Although trampoline_handler would have to be enlightened
to eventually return to original return site.

>
>On Fri, 2024-05-03 at 21:18 +0200, Jiri Olsa wrote:
>>
>> hack below seems to fix it for the current uprobe setup,
>> we need similar fix for the uretprobe syscall trampoline setup
>
>It seems like a reasonable direction.
>
>Security-wise, applications cannot do this on themselves, or it is an otherwise
>privileged thing right?
>
>


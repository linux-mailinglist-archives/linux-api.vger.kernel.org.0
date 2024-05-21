Return-Path: <linux-api+bounces-1573-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E704B8CB4DE
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2024 22:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684A31F215CD
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2024 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E93149C42;
	Tue, 21 May 2024 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bGOtEg9z"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE11494AD
	for <linux-api@vger.kernel.org>; Tue, 21 May 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324547; cv=none; b=mKYFN0Q00gf9aF2Ra5ekPv/3t84wCLZPhJPwz0b3PhQKYW8cve7RNNDSdYm7WB8L+PlP05Duz5eYVYhmy/2QMdFs25heLjJgU1zoJQL7M0TkT1zKVum8ZCE3PpKbbbjsTt6S73tY+BvPS3mlrTi3W7LB52s7akARqxME4nLmk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324547; c=relaxed/simple;
	bh=693jQWAREfUdV/HbHgjOUtkEmsrn6/m+v+a7zyIHVAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUbF+rSvDTx94Z9Lam9vPfLysqshzXrg/hNsHi/SbjyksJq5QjaRyuB2Kmcf+0JJRU1DJO7NFRk88v40NpKWMccw3AD3zKMytahCOXrYUjNNqQoqy6iNzv8ExncfFpuyLgWfaMsGruftVub6/uo7YDYAle/rrILpaUbVdAAExZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bGOtEg9z; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3c3aa8938so107527235ad.1
        for <linux-api@vger.kernel.org>; Tue, 21 May 2024 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716324545; x=1716929345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx+dQv0EXvgLDA60wWUrjQl9mWisglv5nVrYagP1xdM=;
        b=bGOtEg9ziXoNqwXkpqdc4PZ9a/dAbvsOdVOv6Ku83BXj1uzMRgUexqjLybC6vjdwuF
         vyl5BeGOLjczKNcCkP/tIjHejxsaGNV1t1mptXMu8OHmNVQUVRr1aFPnnrhS+z7u9rSi
         TyEsregyM6IsQNW8QbmTkWsVfnJ3mZnyqD95NnLJ649AXvr958c52PadJUiNq6PoD9aX
         5LE815kSLpBWQ9xLvQSEDW9VCUFIgrYXOiFuQ4+2lTiTvo81nZFHYjvdMVPDT7ZwcZb8
         mHVe/kOcJg60Ee14FH4DclNTU8v481dskopZPkQVXtpuo2pu6aNhYA05mXo3veNx73Y9
         WMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324545; x=1716929345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx+dQv0EXvgLDA60wWUrjQl9mWisglv5nVrYagP1xdM=;
        b=s2NXQNXCbSSHp5sMW26ZbDVnXSSm386NjDZb4nzy80JbknZUpEn4lVCySmda4AmU9K
         NCBoP1wPmcu+zjzUJ+jiFsx8l3Y0isKP3/NYsk56UNvzdcrhg1c9P4cFhdLUFC4BF3zk
         PMNqqzqk2QuKzIk9xbF5jyHt5zvaVptPaBK2VkfQb8QSFWTvKXL1VZ09QfXOovhAXwdL
         UEZZkz7UMnKj06/J2bRBcC9ADqLFB8jClnonyJI5xxksvIabSFX0Dxbl3HyGM59DD3/W
         ClKgH7R7UT4SxTg2K1jyCS8L59XAXOkYUgxm/1RLs2ao2gnupylT7Wdq69Lp/b4WVtPH
         1S+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5DaMjnn25yzj5zE8MIr4aWal5M583B80C6wja+K/5DNptPRVRTgmNAU0wBg9EeZf3d1xDPv4fvnnajxsb62XdYdVciBlzHXbV
X-Gm-Message-State: AOJu0YwN9d14uzBX8Jx+BoLJEYoQ+1RF6wc0ixNqw47iYpwtWYIYuoXK
	sQe69PMkCTQGonNIu8ln2jG8WKEw//TvdxkPopNxA5uoDF+lUH9d9wkicccaxnA=
X-Google-Smtp-Source: AGHT+IHlwL8HnlxOnwn8kJ0fVFV55sB/RolsKAbelV78JZZEngYsdS/7UN3t2OKQs87EBwQocJT9nA==
X-Received: by 2002:a17:903:8c6:b0:1dd:bf6a:2b97 with SMTP id d9443c01a7336-1f31ca37710mr787045ad.60.1716324544792;
        Tue, 21 May 2024 13:49:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0958d1e3csm114310545ad.191.2024.05.21.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:49:04 -0700 (PDT)
Date: Tue, 21 May 2024 13:49:01 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCHv6 bpf-next 0/9] uprobe: uretprobe speed up
Message-ID: <Zk0IvZU834RQ7YKp@debug.ba.rivosinc.com>
References: <20240521104825.1060966-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>

On Tue, May 21, 2024 at 12:48:16PM +0200, Jiri Olsa wrote:
>hi,
>as part of the effort on speeding up the uprobes [0] coming with
>return uprobe optimization by using syscall instead of the trap
>on the uretprobe trampoline.

I understand this provides an optimization on x86. I believe primary reason
is syscall is straight-line microcode and short sequence while trap delivery
still does all the GDT / IDT and segmentation checks and it makes delivery
of the trap slow.

So doing syscall improves that. Although it seems x86 is going to get rid of 
that as part of FRED [1, 2]. And linux kernel support for FRED is already upstream [2].
So I am imagining x86 hardware already exists with FRED support.

On other architectures, I believe trap delivery for breakpoint instruction
is same as syscall instruction.

Given that x86 trap delivery is pretty much going following the suit here and
intend to make trap delivery cost similar to syscall delivery.

Sorry for being buzzkill here but ...
Is it worth introducing this syscall which otherwise has no use on other arches
and x86 (and x86 kernel) has already taken steps to match trap delivery latency with
syscall latency would have similar cost?

Did you do any study of this on FRED enabled x86 CPUs?

[1] - https://www.intel.com/content/www/us/en/content-details/780121/flexible-return-and-event-delivery-fred-specification.html
[2] - https://docs.kernel.org/arch/x86/x86_64/fred.html

>
>The speed up depends on instruction type that uprobe is installed
>and depends on specific HW type, please check patch 1 for details.
>


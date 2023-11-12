Return-Path: <linux-api+bounces-33-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A41177E8DE1
	for <lists+linux-api@lfdr.de>; Sun, 12 Nov 2023 02:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFC91C2042F
	for <lists+linux-api@lfdr.de>; Sun, 12 Nov 2023 01:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F43136D;
	Sun, 12 Nov 2023 01:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RcDPHGJH"
X-Original-To: linux-api@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B41360
	for <linux-api@vger.kernel.org>; Sun, 12 Nov 2023 01:24:22 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC330CF
	for <linux-api@vger.kernel.org>; Sat, 11 Nov 2023 17:24:21 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32fb1c35fe0so1853111f8f.1
        for <linux-api@vger.kernel.org>; Sat, 11 Nov 2023 17:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699752259; x=1700357059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5W04PQlZqv3bCKdRWWAr7QM/mGSWd/xIDdryxJpTT1o=;
        b=RcDPHGJHHOOgJZH/wHy6xVxdE2Wmqqk3yma9riLo17z/yv0Lb1uJuXkpImxDPr2hrp
         /18vySr5I6h0DiUMsXlrAuSF0THo/xYorncYJ4Cuftk+nZgMXSWuml0r9X5pU77THFA3
         mFTEkuh7w+nuxLswj8TKIUm+e2wsv4xac0qqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699752259; x=1700357059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W04PQlZqv3bCKdRWWAr7QM/mGSWd/xIDdryxJpTT1o=;
        b=b2VC3Ne0+qqYvWTOY5g3b/33eq/rnKwB/v6NYdQJRTcEN6ute6zpQuJzlKuKOmNzl1
         I+kU3fptp/iX9z+EZByB6kM2ad+f40G6UYc/a/AZPcf1uNjilOeBWt1ooxKX4caRAs8h
         oVGW/8CZBimgz2EancGjYm8hwS4fNMz3qai7djq5Fe2zGvIAEI8CeK9DOsyhUlb5yY4Y
         s6CT3TtLSPUeFi7dgFw/+16eIbOP9KxW/DbKsD+JWdlITzLLe46crhHTDxCWKashW/3F
         DxHRlGpTfCvA3HYc4e55k+b2ITVJ9KrbPtOoHMg3t+UoTIQnwAN0dlAGh8zqDrYYCVWr
         YDdg==
X-Gm-Message-State: AOJu0YwSKuBRAM3crgbpKBC8Ums0rDNHlXRAyPr0Zh+ShUa50SFxNa5v
	kHjGa6opGSx4q3/iapAn+2KUlX98HPoo0EF9rEMX4Q==
X-Google-Smtp-Source: AGHT+IExfYBeSA2HP1fjG2W4UciERq/QcBcKrOZ0CimvEEr0ZROq7PsLbka+Z7BlPZ9VWJbY1u9hbA==
X-Received: by 2002:a05:6000:186b:b0:32d:9b3d:4f69 with SMTP id d11-20020a056000186b00b0032d9b3d4f69mr2756095wri.64.1699752259198;
        Sat, 11 Nov 2023 17:24:19 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id c70-20020a509fcc000000b00536ad96f867sm1671064edf.11.2023.11.11.17.24.17
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 17:24:17 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5440f25dcc7so5070976a12.0
        for <linux-api@vger.kernel.org>; Sat, 11 Nov 2023 17:24:17 -0800 (PST)
X-Received: by 2002:a05:6402:138f:b0:53e:78ed:924d with SMTP id
 b15-20020a056402138f00b0053e78ed924dmr2051608edv.5.1699752257302; Sat, 11 Nov
 2023 17:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com> <20231111132431.GA3717@1wt.eu>
In-Reply-To: <20231111132431.GA3717@1wt.eu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Nov 2023 17:24:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
Message-ID: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To: Willy Tarreau <w@1wt.eu>
Cc: York Jasper Niebuhr <yjnworkstation@gmail.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Nov 2023 at 05:24, Willy Tarreau <w@1wt.eu> wrote:
>
> IMHO it does not make sense to add a syscall for this, please have a
> look at prctl(2) instead, which is already used for similar settings.

Honestly, I don't think it makes any sense at all.

If the key manager people can't be bothered to keep track of their
keys, the kernel certainly shouldn't be bothered with this kind of
huge hammer.

It looks like an active DoS attack to me, by anybody who just creates
a huge process and then sits there giggling as the machine comes to a
complete halt, with the kernel busy zeroing pointless crap.

Do it in user space. And if your user space randomly crashes, you have
other problems - but you can try to use ptrace to catch even that case
if you care.

          Linus


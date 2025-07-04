Return-Path: <linux-api+bounces-4136-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01687AF99B6
	for <lists+linux-api@lfdr.de>; Fri,  4 Jul 2025 19:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CE6054477E
	for <lists+linux-api@lfdr.de>; Fri,  4 Jul 2025 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B611EA7E1;
	Fri,  4 Jul 2025 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fYGjMWzd"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338F7262A
	for <linux-api@vger.kernel.org>; Fri,  4 Jul 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650424; cv=none; b=SDK18Uxr5q4f/yL+2qLvJ1n0vKu2lFDUg1loRSnGfktKW6MF1MoNUB2CDpAiY34Sw4/jPUt1vTt8wEp5kqt4yFKKdNaB+GilLgquT2Mx4iOorObMEjRKy9O1Pps1AV5CLYZp92Z7FecQeOs2Gva/fsdUdRBzdtWb+cG2BsFjJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650424; c=relaxed/simple;
	bh=g370+J4oAIlc+gSe8sWAr1OOMmqeWNX9Dx+iIVgVPY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gt14J5HbZP8BMqG5rGjLjNnxEwYJWgocyGI+rczM7cnnor86dciuNGjCwJn1olIzfu/nDNSkXCoQMOvkrf3rdU1j0PvDW1r/3eAE/i/P+ZMl3rte0MP24F7ljyrXRskn6aXjF8JwcJJOFqGFFCsHvoVJ4hDxA7UTlyU9BWR8v3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fYGjMWzd; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73c89db3dfcso229257a34.3
        for <linux-api@vger.kernel.org>; Fri, 04 Jul 2025 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1751650422; x=1752255222; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FwFrEJSW/XDP4k23qdSFdBRgs+IdGgPj8TzUNPuTlxM=;
        b=fYGjMWzd291KbWvvcxpjoym9F9lZ31SIkH55w12X7BjAGN1POP39gj+NKSDoXRm5fC
         kI7rgWCPScmduTiDbWaUTmDPGLpiY/juuMn2MVmaEsUv+0GXf9g8wvDDpuESrlBdL2en
         YHT0MAyVmPdmOIxzMMbTXGipzPAZzEmOwztx4fLnCaD2BJiuPDD+MZXx++zcSGo5MRfU
         WRZGG+l0tNFFbfZCCoL/HsXn6SGuJjLWOaf0Uq0kjsKvV70oN+nktK8nKUxP9Obv7YrZ
         hwotpBMeTqN/xIb7+7YiVDu6GPGw8zvWP9olBXUSkX+mZNgaGhzlSiPieBqAdotT75kN
         drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650422; x=1752255222;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwFrEJSW/XDP4k23qdSFdBRgs+IdGgPj8TzUNPuTlxM=;
        b=rLyy4H4jMSlovQXMsT3EHblC5OxsajbikrxDHUeE0S/T+eRUfK4UCLjhKnrBSLOIWA
         YaZtGJETfukajXIlcUfM2SIeqzIbL+fAwII5fDWZzff0sge1sdV2qbeRUsWBrcohpzVn
         re7u+0cqBa3IhEWnnbI9brfhlLgsp0OnTgm5308NlxR2CTJrSCXiyScJ0LAk41345sem
         ARgsxALzNcTOq940aGpBNs2EkvuXjoxi1AlxSe6bESdAhI9jjl7Ovbgh8hzu+LIRShnJ
         sX2yBHGKYrawwb3uyLf7Le+MHVMl1VijoEpKNXxVVHgBhy3N1K1ibiIlAqitiuAw7kje
         8ISw==
X-Forwarded-Encrypted: i=1; AJvYcCWcviyF6vGstoonSUlLvoUd2KW3oj9NL6U0de5lmq1tTdNkZDxgg03RJexNRZEDIUk+aIZPSnIdNFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyJfVX7mNTKfoLYptIr/yTHjLaYq0xEAp+TdgpOxLDI9mKcysf
	4B3ZUjLY35QRW5X3m49gPm9OA2SoMB/9wp6iW28Hu3V4u0ADesxMM12ROGsO7+HvxnE=
X-Gm-Gg: ASbGncuKgPvBtbLKZyn3WoBar+o7K0iOuipsuuryY+MG9GPNnUEjwoPva04c/OGADn+
	XS5Lbu5xbXX4SthUT2BTJt0Ie00h31K6ELHjJaKWIWktVzQ9Ws0XuWzQboyRnJakG05egPjT3Oh
	IONjRQ1C6TUryfyGadpmvSuxZeQV5ayDzxRSKtPHWE/to6nd30K5rlgmBZFM4qUMgENnmMKktbq
	hboXl4ISysv3sObFvkUmrBxq1DDMI7FJQJR2F3Jb+oW2qiX7BP/RFUngUwa5A8m7wFJirrdfs31
	DVA+j88wmxKTQsBLJO/giSQbrCLyO2tmBrhC
X-Google-Smtp-Source: AGHT+IG8jf/arRNWeZ/V27MeVDPv9q8tOH67GQicakC0hhED8pz1NEmRiCLJkYYuEA/SMRFjhnAmhg==
X-Received: by 2002:a05:6830:2655:b0:72b:9bb3:67cf with SMTP id 46e09a7af769-73ca12538afmr2504308a34.9.1751650422034;
        Fri, 04 Jul 2025 10:33:42 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f93c9a9sm444799a34.52.2025.07.04.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:33:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uXkI8-00000005znR-19BJ;
	Fri, 04 Jul 2025 14:33:40 -0300
Date: Fri, 4 Jul 2025 14:33:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "pasha.tatashin" <pasha.tatashin@soleen.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, pratyush@kernel.org,
	jasonmiu@google.com, graf@amazon.com, changyuanl@google.com,
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com,
	corbet@lwn.net, rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com,
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org,
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr,
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com,
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com,
	vincent.guittot@linaro.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, david@redhat.com,
	joel.granados@kernel.org, rostedt@goodmis.org,
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn,
	linux@weissschuh.net, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org,
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com,
	myungjoo.ham@samsung.com, yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com, ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de,
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com,
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net,
	brauner@kernel.org, linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 00/32] Live Update Orchestrator
Message-ID: <20250704173340.GL904431@ziepe.ca>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625232653.GJ369@kvack.org>
 <CA+CK2bAsz4Zz2_Kp8QMKxG5taY52ykhhykROd0di85ax5eeOrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bAsz4Zz2_Kp8QMKxG5taY52ykhhykROd0di85ax5eeOrw@mail.gmail.com>

On Wed, Jun 25, 2025 at 07:44:12PM -0400, pasha.tatashin wrote:
> On Wed, Jun 25, 2025 at 7:26 PM Benjamin LaHaise <bcrl@kvack.org> wrote:
> >
> > FYI: Every one of your emails to the list for this series was bounced by
> > all the recipients using @gmail.com email addresses.
> >
> >                 -ben (owner-linux-mm)
> 
> This is extremely annoying, I will need to figure out why this is
> happening. soleen.com uses google workspace.

b4 also seems unhappy with your mail:

  X [PATCH v1 1/32] kho: init new_physxa->phys_bits to fix lockdep
    X BADSIG: DKIM/soleen-com.20230601.gappssmtp.com

Though I spent a few mins trying to guess why and came up empty. The
mail servers thought the DKIM was OK when they accepted it..

ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=VxWLPP8s; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="VxWLPP8s"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8259b783f6so264959276.3
        for <linux-doc@vger.kernel.org>; Wed, 25 Jun 2025 16:18:45 -0700 (PDT)

Jason


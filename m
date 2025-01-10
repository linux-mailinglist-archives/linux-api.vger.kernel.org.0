Return-Path: <linux-api+bounces-2967-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36521A08CB1
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2025 10:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B46B416814C
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2025 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494C20C027;
	Fri, 10 Jan 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIFsE3fM"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFA20C00B
	for <linux-api@vger.kernel.org>; Fri, 10 Jan 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502299; cv=none; b=Gq6lGtAAqJunXes9pQAjfRMWR3ZegxRkbAbrlTYAu8KnHuRbVOWarRTrwFcR2waSJWe1G3kB0UcvPMZNelAKwBSvO/fqip3YfmhWNZ6NOtAlCfjRuB4kIKQtXrKTzNRJ05w/vzZVmg3+p9UojNPV0MEU9m877Iz8h3Mk/i+Ey+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502299; c=relaxed/simple;
	bh=ENLLV/0PrVWHZJnSd10hwquS1U8BMVZB3K1bFjotxyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yoo6BShGSmTHfxcKWnojgilay5TBsHB0/OnjQ6H1FqIza9oXJIf/7aerpHB4NG02hgqW3pqCbpPZDyH6qIp/7nJRCgWjv1EyT9QNGGKNqN8pUkXcAVNBiVIQhBrrCA9mDoGER7tl9tFxbWnDuVpYaJ7iJKtZDm0Abbcw38KUlGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIFsE3fM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736502295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
	b=UIFsE3fM8ZpT28RgTD/VWrQgEAnTkGjPT7UbRMlcM0A3WZUp3DhNJ0v0QFBh450AL2dUF2
	1rk+agWGcGiZ9i74yLeJbYlEoWeR6NzBDaiJjp4lAMBOkt46WyA1BMrDxOCmGN/VpP3McP
	TQbg59XT+08yYB3kLiyn5GjAlHUungM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Rj6c0O6bO_usiTHKPWoKFQ-1; Fri, 10 Jan 2025 04:44:54 -0500
X-MC-Unique: Rj6c0O6bO_usiTHKPWoKFQ-1
X-Mimecast-MFC-AGG-ID: Rj6c0O6bO_usiTHKPWoKFQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385dcae001fso783577f8f.1
        for <linux-api@vger.kernel.org>; Fri, 10 Jan 2025 01:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502293; x=1737107093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
        b=W4e8lbXI1/+aDt3v8W+DpepKgzlJz+8g2bQQx9Gpv2AUoILiEilTGgig6foBfqBNYA
         2bwhsU7oeHc2WJ+7kXEiUh/qREvkr2YHaq+DKtnaUcFhaox2ERwG2ixSNQma/a+9w150
         SMeN8aiKnPexcX+QzWLOsLwsdKAYtMlmQHj0/Gh8esbSgm7tKyrMgnSRnu2c50BY6vb6
         Y/fnNvVIcljUFxhdID5VeotOXuGixCMZzyDrydm1Oci8XjNL4HhcQleIeHtzq8dkoHSz
         9EOBXyxrqXl3QJSNajVK0pWXInikHLwKxymPLR51fjR2t310LgrjeK3eRL0s7LQYSsQU
         +tjA==
X-Forwarded-Encrypted: i=1; AJvYcCVkSVnZXX0667eoYIk6jwwJ4xgPjrTqcIRVoTdkQEz1iC6qN+sTcyz5PlAkPVxabWJ5VjoaOr7uV6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKjwmmyAJcz91D1pxUHhoJgJv1Dw33484lEi8THY9kLqCMyyx
	1MaePA7S1RkLeJ3tN8a3+fOTmFhotripHtGoxAneYM5iN+Qs0Ef9Ek8hly4by952MK2Ssg/jMEZ
	Dedo+UKerW0pc6odLeR10cozBrv/xTBcPdS6nnJVGYqkVMRTWAVcFHu2R
X-Gm-Gg: ASbGncuxHdi4Ifay/g4o/ioh5yMhMR3dYC80W7QiaA9Rk7Bri9JuX1Dm6hG+s8TGOx8
	r32l0g1NHUgvl+rCU0MeDpMRCIjJmlbA2ap7jEshfTsp9eu5SQXGWOxV7izdaIYooCDlsphmOT5
	CKEV+aRtxGIYd2Jgw5v0kxoNw1m/3ZG5+QejsLoCwaerHXfv9WfXmEemeVHyKq2gk5GVN+jYtYd
	43KpxPrqXf0T0JWI+CUlEWORDvv88iiuDtbaCd6FfvDSZrwqqLYgQ8/7qc0Re5wkZet+XVeAGqq
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910083f8f.45.1736502293456;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWMxVaNXeUTe+wjdV2pCbQXCctILb5vVg9f3+psJOjGS23Sr767uuQBsbyCemBlGukLyZjgw==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910059f8f.45.1736502293124;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383965sm4140444f8f.31.2025.01.10.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:44:52 -0800 (PST)
Date: Fri, 10 Jan 2025 10:44:51 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	chris@zankel.net, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <4ad35w4mrxb4likkqijkivrkom5rpfdja6klb5uoufdjdyjioq@ksxubq4xb7ei>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>

On 2025-01-09 20:59:45, Arnd Bergmann wrote:
> On Thu, Jan 9, 2025, at 18:45, Andrey Albershteyn wrote:
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
> 
> You seem to be missing a couple of files here: 
> 
> arch/arm/tools/syscall.tbl
> arch/arm64/tools/syscall_32.tbl
> arch/mips/kernel/syscalls/syscall_n32.tbl
> arch/mips/kernel/syscalls/syscall_n64.tbl
> arch/mips/kernel/syscalls/syscall_o32.tbl
> 
>        Arnd
> 

Thanks! Added

-- 
- Andrey



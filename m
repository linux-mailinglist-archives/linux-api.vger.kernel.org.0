Return-Path: <linux-api+bounces-2102-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB294689B
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 10:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 306ED281ECC
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024CD13D53E;
	Sat,  3 Aug 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ruzgn3DL"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FAA23CB
	for <linux-api@vger.kernel.org>; Sat,  3 Aug 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722672068; cv=none; b=OnGESxAvWjZKfWWCzxODqdeiC3QIEkRWRtQtN3pvpXq0zmsoGld7hT89NUifgbCOBak/Nrg5yLS9cRLFXqYs7GSrZH4cDKeBKNVJVF3zcCW8m2k7/BHchFvInbiELX0iyoWxFb9iUF4lpFs0/iCmA3wSPkTOVEBAT8a/C6P6mXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722672068; c=relaxed/simple;
	bh=ICoSMWNZ5soFFQALhyx1p+h8nSp+ARvZKTF52R1qkpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSUd8aKRFXW5CjtQywI237H4x7kHQJZLHf4nPpxJPNuDJUCv5dqn2jvgOalEiSVQsAG1IFvZYFui1OTgwJnCO1hEDrC2iwME5aS4Ti9m7vQMrpACeEGRgEfkSovoc+/mdvJmsQZs6P7am+U87AlLPedlfyjClBVQi47hTwKEE6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ruzgn3DL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722672066;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=ChVTiGdYPFEhWu1znKPIMwiy58kLR6qAS9OD9lZfQ0M=;
	b=Ruzgn3DLAbPhYj1/HksbHNC/X3itTJOi76HiPnqaA4fpmDfTNljfJwki8CrLub2Wi/vYJX
	MRiGAg3QUgtt4ieYM8lbUXz2gjZSQ/Izpphot81j12v5Odc20ufxkbLIz9TuoPS4FeoHiH
	1maHG5QbHoSn96m7jBJuVz0IM2xTJ5E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-i1KcjCVDOlW0clbpFo74aw-1; Sat,
 03 Aug 2024 04:01:00 -0400
X-MC-Unique: i1KcjCVDOlW0clbpFo74aw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FC0C19560A1;
	Sat,  3 Aug 2024 08:00:51 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.45.224.25])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20CAF300018D;
	Sat,  3 Aug 2024 08:00:48 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 47380i3q931236
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 10:00:44 +0200
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 47380fEc931235;
	Sat, 3 Aug 2024 10:00:41 +0200
Date: Sat, 3 Aug 2024 10:00:41 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Rudi Heitbaum <rudi@heitbaum.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, Florian Weimer <fweimer@redhat.com>,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        WANG Xuerui <kernel@xen0n.name>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH] syscalls: fix syscall macros for newfstat/newfstatat
Message-ID: <Zq3jqeq6USL066k+@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20240801123305.2392874-1-arnd@kernel.org>
 <Zq28wejX3U9J1_JV@faede8dcc269>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zq28wejX3U9J1_JV@faede8dcc269>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Aug 03, 2024 at 05:14:41AM +0000, Rudi Heitbaum wrote:
> With this patch to kernel 6.11-rc1 the error whilst compiling gcc-14.2 for
> aarch64 with libsanitizer has changed from '__NR_newfstatat' to
> '__NR_fstat', so some change, but still fail8ng.
> 
> sanitizer_syscall_linux_aarch64.inc:13:23: error: '__NR_newfstatat' was not declared in this scope
>    13 | #define SYSCALL(name) __NR_ ## name
>       |                       ^~~~~
> 
> sanitizer_syscall_linux_aarch64.inc:13:23: error: '__NR_fstat' was not declared in this scope
>    13 | #define SYSCALL(name) __NR_ ## name
>       |                       ^~~~~

Probably it would be useful to check
echo '#include <asm/unistd.h>' | gcc -E -dD -xc - | grep '#define __NR_' | sort
for all arches between 6.10 and the latest git, diff them and resolve any
unintended differences.

	Jakub



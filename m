Return-Path: <linux-api+bounces-2120-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B09482AC
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E4F2835E6
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 19:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCC16B743;
	Mon,  5 Aug 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3soiTJy"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4007A166F3B
	for <linux-api@vger.kernel.org>; Mon,  5 Aug 2024 19:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887644; cv=none; b=ij+MIBSL7k9X+ph1gbhGdM2Tlahq9Ll4GBR4anBQQSiasMsFhRbA1jX4ds3BDpIZ/h+7EkuVK+LdHWe5hARDAhVUOPwrQo6KTsXkR+7WolO8dsHWJIHH/f0l+9RvXIj1+qRUKBQHkl+lkD8xSXiQNjXlLQ3/Oa4/jroK6M1nMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887644; c=relaxed/simple;
	bh=o0KRaGzHCorXV7S0Y9guHcptlqEd7xwMn/1FdZD4bPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gm0h6Noa2jKR/TC0+fRvPGiWgzDzf2vvjMmteX/qM9ZxG33E3q2b9oolwRjp9ZZQpt4IDK1uUBSJ/3RwxZPoE2kXGi35x1iW3zD6c1lD9XuDOKfn2F5eXNLV/4cBcMGQe51c2gb9UAELR6XDFSGHiz0wbbhj8x9Xh0nLAPAniq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3soiTJy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722887641;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=QMcB7PhofnR3QJhm5j9PvLH/K7OQu77lKAt5++u+MFU=;
	b=d3soiTJyg+M7NQzvnPWri21udRL9RLWVOpzABG0oYWCN2MEZ12iKfN2za76y2yEgDjUmHr
	W7lHiNy9sOTzPHnKohb/mRZ+TVhIO7c6eKu/SMoJvfqpuW0obrWueZoQQYE9nYD5XPiURT
	QGwM0gKn1IRAB5PddpfyDjohvf1udaQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-JDnuY8mBNhiOQheAGsfQPA-1; Mon,
 05 Aug 2024 15:53:57 -0400
X-MC-Unique: JDnuY8mBNhiOQheAGsfQPA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA6701956080;
	Mon,  5 Aug 2024 19:53:53 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.45.224.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C8CA1955D42;
	Mon,  5 Aug 2024 19:53:51 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 475Jrm4I3885874
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 21:53:48 +0200
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 475JrjfI3885871;
	Mon, 5 Aug 2024 21:53:45 +0200
Date: Mon, 5 Aug 2024 21:53:44 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rudi Heitbaum <rudi@heitbaum.com>, Arnd Bergmann <arnd@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>, Florian Weimer <fweimer@redhat.com>,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-api@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: Re: [PATCH] syscalls: fix syscall macros for newfstat/newfstatat
Message-ID: <ZrEtyJd2qydKcWxQ@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20240801123305.2392874-1-arnd@kernel.org>
 <Zq28wejX3U9J1_JV@faede8dcc269>
 <Zq3jqeq6USL066k+@tucnak>
 <c78916da-ee59-4ecb-9886-7bbc7f077fa5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c78916da-ee59-4ecb-9886-7bbc7f077fa5@app.fastmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Sat, Aug 03, 2024 at 10:12:47AM +0200, Arnd Bergmann wrote:
> > Probably it would be useful to check
> > echo '#include <asm/unistd.h>' | gcc -E -dD -xc - | grep '#define __NR_' | sort
> > for all arches between 6.10 and the latest git, diff them and resolve any
> > unintended differences.
> 
> Right, I should have done that before the original series really:
> I spent a lot of time validating the kernel's internal changes for
> consistency (which found a dozen bugs that were unrelated to my
> series) but missed the unintended changes to the external header
> contents.
> 
> I'll do that now and send another fixup.

I've done 6.10 to 6.11-rc2 <asm/unistd.h> comparison just for the Fedora
arches (x86_64, aarch64, ppc64le, s390x, i686).  Full details in
https://bugzilla.redhat.com/show_bug.cgi?id=2301919#c8
On i686, ppc64le and s390x there are no changes.
On x86_64
#define __NR_uretprobe 335
has been added, perhaps that is intentional, haven't checked.
On aarch64 when going just after __NR_ defined macros and their values,
I see:
#define __NR_nfsservctl 42
#define __NR_fstat 80
#define __NR_arch_specific_syscall 244
#define __NR_syscalls 463
removal and
#define __NR_newfstat 80
and addition and then
#define __NR3264_fcntl 25
#define __NR3264_statfs 43
#define __NR3264_fstatfs 44
#define __NR3264_truncate 45
#define __NR3264_ftruncate 46
#define __NR3264_lseek 62
#define __NR3264_sendfile 71
#define __NR3264_fstatat 79
#define __NR3264_fstat 80
#define __NR3264_mmap 222
#define __NR3264_fadvise64 223
macros are removed as well (let's hope it is an implementation detail and
nothing uses those macros, but some search would be helpful).

	Jakub



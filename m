Return-Path: <linux-api+bounces-2121-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5539483D3
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 23:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4FDAB2165D
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5794616B388;
	Mon,  5 Aug 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="P+jmOc0c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDxg+tG/"
X-Original-To: linux-api@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6414BFB0;
	Mon,  5 Aug 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722892060; cv=none; b=L98manGbmeXYjc7gyGdnDBDN+DiuKSph8AbzKoXC5xU4brVvBMotOMPAypAAd9MjmQUyDLlXIjowv4igARUnG48reE6izAgRkMK6ftmsFiQOcZFF0q4qtIR1hEy0xT4Dj1+jKFez25GlFkYu3RUpUZev/l7GFfmXvjVUj77/TkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722892060; c=relaxed/simple;
	bh=skS/AJncNxLqI2yM6gOMemlUYOTiAl+DGcXfyQzOzDg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bghlk/YiYWcgLUJEzVuXynLvUeUr/tShTJjuA/IFogquUlzuzVwoVfgjhGNnmraNArcoNXKW/cpTP43xUyQ1g/ry/U6suQI1zdukl+kUuj+WutEWce7rJu8xU4sLZ8f8WYQSJWcCs/uq8HeOwLHWgO2mZb8BkTG+YuCNCOphDrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=P+jmOc0c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDxg+tG/; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 300101382F9A;
	Mon,  5 Aug 2024 17:07:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 05 Aug 2024 17:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1722892057;
	 x=1722978457; bh=tXBWfo0rLBVvDIsHuehFdN8/T8xi3wWv1m9UP4W8yWY=; b=
	P+jmOc0c0Tzk6v8capJcythtt4MaUpvQYSuCmOIPAGiMG1TondoP+HKMhomRMkt4
	Q8ibhZRhrVqtSZITHUfGtBez7mWTFYXYmgV0cC19H/FCXuDulEydRmkcNzORXx57
	IXxqrkLiRWemLnE3hRSbzHIdR+PI90Bi1w7+WQHYknqDENekl0ykyVsZu3m17msh
	sD+YIE3LaKkboQFtuCEcBWYRxlrgKfmOG60RrBt7UzgihApSeq102bioDnZPDmSi
	zedyrKqGhngozlajJ7NVtb1y80f8QZNGFUwHVxsLSMCsAb18Bl+YzpaCCEAfCp0f
	U3yCBiNzSwE2yNMdtXf75w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1722892057; x=
	1722978457; bh=tXBWfo0rLBVvDIsHuehFdN8/T8xi3wWv1m9UP4W8yWY=; b=W
	Dxg+tG/JQZqtE2/7EolizRLTJw5KRIURzRXjgkn4MWkBnLxi38e646cG6uYai9BM
	/jCCdNf+G0FmzS2it3fmJbRbAqFEMJjOOW2Ka+hAr+EvZWioFgDZ8M8urlv+mimG
	48TZDo4guKnY07FlK57tkIxbrZ5Ym3emPcJeG8SvpHpDIXqvjOyPPWM9v++rsKHs
	GBOlIblje5jAdLTLjmvd3efiS+W1BxZ7D2oFrJgcGpNK5OgZ1YsbHyUf88TdXnO7
	oYZ/TmmiHJAOEMiBDFFfNZii9r1CIFgkGWIBtRaQ4fDgxzbVGdrUIFNgUxu/YD7J
	x+tEzAQ6HkAviwm792baQ==
X-ME-Sender: <xms:GD-xZhlTazEV78QF7P2ssFyXR4GeyuauPkXazKWJYaT2GGFwIv1djA>
    <xme:GD-xZs3zXAjyB8w9wbkoNoMLbW_ZHdY_0FPz7Z9LnmGMpqoJQiIR8pNMgNiNtFG5J
    4FNOl0f33TX5lmO0dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdduiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepledtjeekkedtgeeiudduveekgfeugeeftdeigfejtedufefggfekvefgtdeu
    ieffnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggp
    rhgtphhtthhopedt
X-ME-Proxy: <xmx:GD-xZnpU-pB2lUFdnhqLAzDNRSeZZEpAxfR0E_aQ4fIeTFfXtJJ1Lw>
    <xmx:GD-xZhkA15N-6py0-a3WOfPg-FxmWi9QqX8H8jErBTICHH18t-qNmw>
    <xmx:GD-xZv1E8R30rYIg2oKAhUddV4jLdn92NUambpFYg_deRBNt1FDv5w>
    <xmx:GD-xZgtK2AOHou5A95thS82BJ0wmc2xZcK--yfvwZPoxAqXLm4bQjA>
    <xmx:GT-xZj48glhUhQptunOq1eCXotrnbEhVuaak-YDbCeNvpXlwAWPeptf3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E5835B6008D; Mon,  5 Aug 2024 17:07:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Aug 2024 23:07:15 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Jelinek" <jakub@redhat.com>
Cc: "Rudi Heitbaum" <rudi@heitbaum.com>, "Arnd Bergmann" <arnd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Huacai Chen" <chenhuacai@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Andreas Schwab" <schwab@suse.de>, "Florian Weimer" <fweimer@redhat.com>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-api@vger.kernel.org, "WANG Xuerui" <kernel@xen0n.name>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev
Message-Id: <d56f8ba8-21b5-43bc-9726-bd24346ef16a@app.fastmail.com>
In-Reply-To: <ZrEtyJd2qydKcWxQ@tucnak>
References: <20240801123305.2392874-1-arnd@kernel.org>
 <Zq28wejX3U9J1_JV@faede8dcc269> <Zq3jqeq6USL066k+@tucnak>
 <c78916da-ee59-4ecb-9886-7bbc7f077fa5@app.fastmail.com>
 <ZrEtyJd2qydKcWxQ@tucnak>
Subject: Re: [PATCH] syscalls: fix syscall macros for newfstat/newfstatat
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 5, 2024, at 21:53, Jakub Jelinek wrote:
> On Sat, Aug 03, 2024 at 10:12:47AM +0200, Arnd Bergmann wrote:
>> > Probably it would be useful to check
>> > echo '#include <asm/unistd.h>' | gcc -E -dD -xc - | grep '#define __NR_' | sort
>> > for all arches between 6.10 and the latest git, diff them and resolve any
>> > unintended differences.
>> 
>> Right, I should have done that before the original series really:
>> I spent a lot of time validating the kernel's internal changes for
>> consistency (which found a dozen bugs that were unrelated to my
>> series) but missed the unintended changes to the external header
>> contents.
>> 
>> I'll do that now and send another fixup.
>
> I've done 6.10 to 6.11-rc2 <asm/unistd.h> comparison just for the Fedora
> arches (x86_64, aarch64, ppc64le, s390x, i686).  Full details in
> https://bugzilla.redhat.com/show_bug.cgi?id=2301919#c8
> On i686, ppc64le and s390x there are no changes.
> On x86_64
> #define __NR_uretprobe 335

This was a bit of a wild ride, but I think this number one should be
final, and only exist on x86-64.

> has been added, perhaps that is intentional, haven't checked.
> On aarch64 when going just after __NR_ defined macros and their values,
> I see:
> #define __NR_nfsservctl 42
> #define __NR_fstat 80

__NR_fstat was a very embarrassing bug that I introduced
while trying to fix __NR_newfstatat. I got confused by the
the way that the kernel internally uses newfstat() and
newfstatat() as the name, while the only macro name
for fstat() is missing the 'new'.

I also added a patch to add back __NR_nfsservctl to avoid
the unintended change, but this one is less clear since we
already dropped that macro on some architectures while
converting them to the new format but left the macro on
other architectures.

The syscall itself was removed in linux-3.2.

> #define __NR_arch_specific_syscall 244
> #define __NR_syscalls 463
> #define __NR3264_fcntl 25
> #define __NR3264_statfs 43
> #define __NR3264_fstatfs 44
> #define __NR3264_truncate 45
> #define __NR3264_ftruncate 46
> #define __NR3264_lseek 62
> #define __NR3264_sendfile 71
> #define __NR3264_fstatat 79
> #define __NR3264_fstat 80
> #define __NR3264_mmap 222
> #define __NR3264_fadvise64 223
> macros are removed as well (let's hope it is an implementation detail and
> nothing uses those macros, but some search would be helpful).

I did a Debian codesearch search for these and did not find
anything other than a couple of language bindings that copied
these from the kernel headers but nothing actually using them.

All of the above are implementation details that only
existed on arm64/riscv/loongarch/arc/openrisc/xtensa/nios2
because they were still using the old unistd.h format, and
they don't exist on any architecture that generates the
files from syscall.tbl.

      Arnd


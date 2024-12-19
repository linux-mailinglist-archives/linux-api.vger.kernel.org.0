Return-Path: <linux-api+bounces-2942-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8D9F75FC
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2024 08:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A7B16921A
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DA32163A9;
	Thu, 19 Dec 2024 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0PaeD2mZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36422216E34
	for <linux-api@vger.kernel.org>; Thu, 19 Dec 2024 07:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734594308; cv=none; b=AGWwgHR+saph0xVvIjgXtJco/LfuOiUSmk/0BLnev2wop4FlqIoHguIjFIVvQJD9UYj/pO7Bl15JfooTab0Q3akRrg2iPTRdhwd8MWhI/nDHfD50uUQ0U6H8WoIfXHi1YgKYOgwhzwunC7BxHnY6fcxFuAlMamr20Bc9lLrQSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734594308; c=relaxed/simple;
	bh=4kZV05gAcdH13bba/KY+LydZ9n98bA1dNYEnzu9VffA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1NH1u5BjcSaqn4jm22eFtJnv9wM81ljd/B6KsAxQ7iEvBF2PHV6CWGIo/i/9cyQF065AV7uX79+rSV4uYwNIj6w3YuMsoneJYuGtSAy+TK2erFrZxwApy0ebr5SVyjWHHkNrXMQnSk38+IMWlAtOuGzkNyqCGvpCJJ+BqYgBo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=0PaeD2mZ; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YDMyk2gCKzf38;
	Thu, 19 Dec 2024 08:45:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1734594302;
	bh=oKhFkfeKlHLMteV17dJwPYDJMj25IWwSaNtedn4t5og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0PaeD2mZXMVXSB0s3zaJLGesGRhVGJwjco61VkN0AtFjed07nbQSnjPZq0OMG4Uiu
	 6GGqjloRLZ+q2vtgOzexlRTyqCRQmT7TjrWl+anvbdbs6ryn0zJs5ggkQ/7y6qXsl9
	 4EbXr0LzwyzvuSLNxj4fMgTNVxzVW43NV/jKyqCA=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YDMyf3syCzYXg;
	Thu, 19 Dec 2024 08:44:58 +0100 (CET)
Date: Thu, 19 Dec 2024 08:44:56 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <serge@hallyn.com>, Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jordan R Abrahams <ajordanr@google.com>, 
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, Theodore Ts'o <tytso@mit.edu>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v23 0/8] Script execution control (was O_MAYEXEC)
Message-ID: <20241219.CaiVie9caNge@digikod.net>
References: <20241212174223.389435-1-mic@digikod.net>
 <20241218.aBaituy0veK7@digikod.net>
 <202412181130.84A2FCF2@keescook>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202412181130.84A2FCF2@keescook>
X-Infomaniak-Routing: alpha

On Wed, Dec 18, 2024 at 11:31:57AM -0800, Kees Cook wrote:
> On Wed, Dec 18, 2024 at 11:40:59AM +0100, Mickaël Salaün wrote:
> > In the meantime I've pushed it in my tree, it should appear in -next
> > tomorrow.  Please, let me know when you take it, I'll remove it from my
> > tree.
> 
> Thanks! Yeah, I was just finally getting through my email after my
> pre-holiday holiday. ;)
> 
> I'll get this into my -next tree now.

Thanks, I just removed mine.

> 
> -Kees
> 
> -- 
> Kees Cook


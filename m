Return-Path: <linux-api+bounces-4622-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32CB3740F
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 22:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED237B48C6
	for <lists+linux-api@lfdr.de>; Tue, 26 Aug 2025 20:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A3E281508;
	Tue, 26 Aug 2025 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Q1ARfjwu"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C830CD99
	for <linux-api@vger.kernel.org>; Tue, 26 Aug 2025 20:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241586; cv=none; b=XQ00+9Ts+RW/0FyHoSxu8e68RwA4JP/gvznoz8WsPdpMiS2Ah9D2b0fsAglDYJBkSWmkBdr+/C6XdwTTTsnYyojE0nDSD0hoUu/1GW9ZfK+GWuFp97RCVLIY4OpOOv7OMv6uHcNCXNP9TwR7U9VGWsCRcT8+2B26yD+LJx0enbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241586; c=relaxed/simple;
	bh=/gJh2QllT6rTS6ys1eyGslAmvkDqLO+tfVaA0jNRs3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N33RHwO2ZLznIZHCIrlI4TWN7tydNgxSHTDdPn9b8SEvQacX8I7BT7wPN1sJOe9aHbc8DfW1sSPtzZt6eM0unOG4jT0xESkgk7hFDTLYr71dpFIGYUOHY4wsMeG00EgZ6/FK7MNdXpXZyEDL2GTjLOw66TgdYpSANrLx5AqL/f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Q1ARfjwu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-119-77.bstnma.fios.verizon.net [173.48.119.77])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 57QKowgK005727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 16:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1756241464; bh=v5oDFv0dgAPRpziVWFPx6zdFfgff+kVk8oRL4Pe1b1Y=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=Q1ARfjwu71oSkJlLMRLzzm2JN69hQGM1WvgsY5EY3+q98/n6dom5NJc6+WimJFJ3T
	 B7TYI4dgHUOuoz0y4mgTXm3/8l821W0KPSA3SC/2uRmT1YRUk6nkig9dXTW98axLsl
	 PySNicn6h7sntg32HF03DpOtccWEbyJXZxm8NgpAvJa/QJuzX8W1EbKpc+3BsMBXJ6
	 AXVHDhhbOMvY8uZrpPPT7E8DJZGoldPeeEInngiX8ldxwfjnVFRseaKAv+06eINfSY
	 icCTfTS3d4PpDP9Zjj7u6ITUPMKycEVz8eAyA4edVAeKl8QwO3/7IILoJ9JQ3PxtPP
	 aPcAeiSs+hnxQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DE47D2E00D6; Tue, 26 Aug 2025 16:50:57 -0400 (EDT)
Date: Tue, 26 Aug 2025 16:50:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Serge Hallyn <serge@hallyn.com>, Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Heimes <christian@python.org>,
        Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>,
        Fan Wu <wufan@linux.microsoft.com>,
        Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>,
        Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Jordan R Abrahams <ajordanr@google.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Luca Boccassi <bluca@debian.org>,
        Matt Bobrowski <mattbobrowski@google.com>,
        Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Robert Waite <rowait@microsoft.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Scott Shell <scottsh@microsoft.com>,
        Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Add O_DENY_WRITE (complement AT_EXECVE_CHECK)
Message-ID: <20250826205057.GC1603531@mit.edu>
References: <20250822170800.2116980-1-mic@digikod.net>
 <20250826-skorpion-magma-141496988fdc@brauner>
 <20250826.aig5aiShunga@digikod.net>
 <20250826123041.GB1603531@mit.edu>
 <20250826.iewie7Et5aiw@digikod.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826.iewie7Et5aiw@digikod.net>

On Tue, Aug 26, 2025 at 07:47:30PM +0200, Mickaël Salaün wrote:
> 
>   Passing the AT_EXECVE_CHECK flag to execveat(2) only performs a check
>   on a regular file and returns 0 if execution of this file would be
>   allowed, ignoring the file format and then the related interpreter
>   dependencies (e.g. ELF libraries, script’s shebang).

But if that's it, why can't the script interpreter (python, bash,
etc.) before executing the script, checks for executability via
faccessat(2) or fstat(2)?

The whole O_DONY_WRITE dicsussion seemed to imply that AT_EXECVE_CHECK
was doing more than just the executability check?

> There is no other way for user space to reliably check executability of
> files (taking into account all enforced security
> policies/configurations).

Why doesn't faccessat(2) or fstat(2) suffice?  This is why having a
more substantive requirements and design doc might be helpful.  It
appears you have some assumptions that perhaps other kernel developers
are not aware.  I certainly seem to be missing something.....

    		  	    	    - Ted


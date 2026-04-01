Return-Path: <linux-api+bounces-6052-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBGkKDbszGk/XwYAu9opvQ
	(envelope-from <linux-api+bounces-6052-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 11:58:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6C3781A9
	for <lists+linux-api@lfdr.de>; Wed, 01 Apr 2026 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB9A9306F2EA
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2026 09:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AEA363C53;
	Wed,  1 Apr 2026 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mzlfg+53";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pGu61XIF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gknx2IGg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hVhZh1rP"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC9382F2F
	for <linux-api@vger.kernel.org>; Wed,  1 Apr 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775036683; cv=none; b=Xc6p3HL/pDSyPItsDqESHa93YmtBkUDIod1PS3Gt0YCx9Bmj9xGi4dkm9S9m7/IZULRNLv5rNTMcwnotS/A9St6spyC3HSFfi8vsU69WVBNLGgjN0C8Cg4/VjipQaTdS8GCAIkbq4WSqQg2uDSwgs1Qb/KK6B86/zz5xptN0vrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775036683; c=relaxed/simple;
	bh=FoWgwIPII31w9IloJ01wrIjQh4siWeW3ph18YCi9JGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgW0s+/uMbkUpOfRma4CkpvJM9kE4wBMdC3p29qhmngrpPGA5CWtwEfb245ouFfXJvm7jd0QWrXYDWczUxkP8BKqZQ5NSg5mVRJN79U507rYWTTWuNgF64ohRhiOvv+/sev8jc2wNVcu3K3ZQnfpyO6zJqZtnkfKjFpUiUj/gXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mzlfg+53; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pGu61XIF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gknx2IGg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hVhZh1rP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AA054D2CA;
	Wed,  1 Apr 2026 09:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775036680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZvktBZcpJDhL07WKyupr1O/mQs6dyCJ+xGrltnKO60=;
	b=mzlfg+53zJ+6CU0l+KzBTOFAAIA2n8yVD19k2u+/tlgpfK9/KoEkUQWJHs54Wj+Ge4dtuL
	oE4ta+cCIpvXlxvtlWzFOjAYC2e6HalHAokVsaQFCSeiwVxmD3/EcsKAxV37t6JozvCZot
	88yziSiDPlNZMdUdpEmrav1l1iDXtbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775036680;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZvktBZcpJDhL07WKyupr1O/mQs6dyCJ+xGrltnKO60=;
	b=pGu61XIFhzy7d6C0FtwZCC5T6p8l2SCCNvbLD2OblwCp9nHddY9JWHCXP0OK2vXAWVd5LA
	R1++6YJi2rXdcuCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Gknx2IGg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hVhZh1rP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1775036679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZvktBZcpJDhL07WKyupr1O/mQs6dyCJ+xGrltnKO60=;
	b=Gknx2IGgBCgC9M/i4cykkUhPrlLdIent4K7Gn7h9dhzAZLF2wvYFqOnFAQWSw11qrUaVWz
	SBzdO9D4zDZ3/cj6BfGNFdluS4vjotCpooKmR9mmLbgluTtpYJygHYfjOnmd1fgZ4yBhER
	2RG2I8lB7/k1oiutp/Y0zUybvh7pzG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1775036679;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rZvktBZcpJDhL07WKyupr1O/mQs6dyCJ+xGrltnKO60=;
	b=hVhZh1rPS6dE2FDgo2OhXFUX7e1eT7yrFlhBFDuzRxVmEM4rnUTad+1Sr43KgSrbQUwxr6
	TP8YHxzRg3/ML+CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8CE54A0B0;
	Wed,  1 Apr 2026 09:44:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B1efOAbpzGleVwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 01 Apr 2026 09:44:38 +0000
Date: Wed, 1 Apr 2026 11:44:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	cmirabil@redhat.com,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Message-ID: <aczpCi_6lm7GQCNY@yuki.lan>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
 <20260331172011.3512876-2-jkoolstra@xs4all.nl>
 <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pbobkjhtuli53o3z34ajyxztaosmztwlygxfxhhjq5ajt47inc@ngtoge3ucdm5>
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6052-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com,infradead.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrubis@suse.cz,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:dkim,suse.cz:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2F6C3781A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!
> I tend to agree mkdirat_fd is not a good name for the syscall either,
> but I don't have a suggestion I'm happy with. I think least bad name
> would follow the existing stuff and be mkdirat2 or similar.

Why not mkdirat_open() as it does combine these two syscalls into one?

-- 
Cyril Hrubis
chrubis@suse.cz


Return-Path: <linux-api+bounces-1692-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80590210D
	for <lists+linux-api@lfdr.de>; Mon, 10 Jun 2024 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A97628755F
	for <lists+linux-api@lfdr.de>; Mon, 10 Jun 2024 12:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E9277113;
	Mon, 10 Jun 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wnz26ipn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Wnz26ipn"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9961F171;
	Mon, 10 Jun 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718020829; cv=none; b=lf72g5Azr7ED5tKEYfRuK3/6jj6DTuLuMQIW+BL76CFnTtx7a6uZTrr2SisYCYjEy++vjRmbrW+DM6Zeqnxa90l2s6Lz5aPAVn6lQe74Xu8uYoe8IrC0+g6EwWb5sjFpJW0eT52WrbnzTMCw6t8YGMIH0FvUuBCFTgyPHxIGdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718020829; c=relaxed/simple;
	bh=acUR3zUJwolkHUEToKVKtJFNeC9oRwyTpo2IsGwK7Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYlUgTSfGLRIzqG8vZGBGAQ2FYKuVmG2XEY046+MvIKke505FxO0Np/WuqTGGIN4DZ8wAVdH/qt5bu97dcHw6WfwnELb9+uuH4t+sWcqeoe+Uk2k7ogHzQ+7nQdjqR3XzmNMyQ1ADuHDgK9HbHphz2Kh1rqKVb3VMuFOouFZSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wnz26ipn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Wnz26ipn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51A411F7F0;
	Mon, 10 Jun 2024 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718020826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a0YO74G5ZN6eUsTagdB66KLLDnxZNwj4Mba32IuxoE=;
	b=Wnz26ipn69xTzQFmPeEPoPPT/LMjAAyDQB0T1j6WPf4TE5WsHZmWjg13mUi4LMriSZGOWF
	ej+OP9Van/MA3afU3UV0ZL+32iv+dE6eV9FAl/zouKoafQNMM3Y28gyC3feWC5wiGh9wQX
	8DvTmh5Wbo/GaJ0/Tl/D3qzljrlX0bQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Wnz26ipn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718020826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8a0YO74G5ZN6eUsTagdB66KLLDnxZNwj4Mba32IuxoE=;
	b=Wnz26ipn69xTzQFmPeEPoPPT/LMjAAyDQB0T1j6WPf4TE5WsHZmWjg13mUi4LMriSZGOWF
	ej+OP9Van/MA3afU3UV0ZL+32iv+dE6eV9FAl/zouKoafQNMM3Y28gyC3feWC5wiGh9wQX
	8DvTmh5Wbo/GaJ0/Tl/D3qzljrlX0bQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 325AB13A7F;
	Mon, 10 Jun 2024 12:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3cJMCdrqZmYEGgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Mon, 10 Jun 2024 12:00:26 +0000
Date: Mon, 10 Jun 2024 14:00:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Jann Horn <jannh@google.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Zmbq1dGPIYdRLw5_@tiehlicka>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-2-Jason@zx2c4.com>
 <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>
 <Zlm-26QuqOSpXQg7@zx2c4.com>
 <CAG48ez3VhWpJnzHHn4NAJdrsd1Ts9hs0zvHa6Pqwatu4wV63Kw@mail.gmail.com>
 <ZmMamtll1Yq1yfxc@zx2c4.com>
 <CAG48ez0pan8aLGjHtoDdrpiP+e5YrGeuD_RzDXgzUwkUvWYLjA@mail.gmail.com>
 <CAG48ez1k0J013tYLfmnT8NXRpG_5BR10xnH8r-yRvTLpJe-nLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1k0J013tYLfmnT8NXRpG_5BR10xnH8r-yRvTLpJe-nLA@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 51A411F7F0
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

On Fri 07-06-24 17:50:34, Jann Horn wrote:
[...]
> Or, from a different angle: You're trying to allocate memory, and you
> can't make forward progress until that memory has been allocated
> (unless the process is killed). That's what GFP_KERNEL is for. Stuff
> like "__GFP_NOWARN | __GFP_NORETRY" is for when you have a backup plan
> that lets you make progress (perhaps in a slightly less efficient way,
> or by dropping some incoming data, or something like that), and it
> hints to the page allocator that it doesn't have to try hard to
> reclaim memory if it can't find free memory quickly.

Correct. A psedu-busy wait for allocation to succeed sounds like a very
bad idea to imprint into ABI. Is there really any design requirement to
make these mappings to never cause the OOM killer?

Making the content dropable under memory pressure because it is
inherently recoverable is something else (this is essentially an
implicit MADV_FREE semantic) but putting a requirement on the memory
allocation on the fault sounds just wrong to me.

-- 
Michal Hocko
SUSE Labs


Return-Path: <linux-api+bounces-3960-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609CAE6B3F
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 17:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EDC53B4F84
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0EE274B4C;
	Tue, 24 Jun 2025 15:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvlrnM2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="du7Ec+1k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvlrnM2f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="du7Ec+1k"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63990274B51
	for <linux-api@vger.kernel.org>; Tue, 24 Jun 2025 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778836; cv=none; b=DWKNhFWJFR+7DzxUEjNnSSRdNOiFC9WSwoQsiwkCa3NmqQoa/VGRlIFMpBb+yw+uVcoG3B6rmEyXMWO6J+Oqn3/i3FMd0QE5sU+nOmCTAeLE49LOD1ioP5kKZjxzIEtrN+Mi9HZL3MF009QT8VV+qPc3GkXCafJU76DOLPV6EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778836; c=relaxed/simple;
	bh=zjZ/DNIXvK66lZcm+P5jsRfEbkkov/vhsRsVKMmico0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qN+bDXmkGxNQ7VtNhYgwO9Cgp2SGghrl05+rZIVaN82H0yJgtdPQTWORev2l7G2/gQol2zhml3WVKIwRnb4xRy6jAZ/9+ghxjdFLdcxd38RwuQlFERUt2mnNg9rV5MxQNczL9PLmXHz+5RsXcKFgba25r9QFGhMgp/pAadwYqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvlrnM2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=du7Ec+1k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvlrnM2f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=du7Ec+1k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E97F21188;
	Tue, 24 Jun 2025 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750778832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoiiUm2Fj9WK2+okdYgOSWwXKVvL+oEsvy7xNbG15iI=;
	b=vvlrnM2feTpV6+ta6uoKsfyvo3trinlhBI684D+M0ahVSjSaUP4cZoBGdLt58BhJywQwse
	U98pFOyfr5XwpUaZ2FENX5MgnKN3Jkq52RzP/AQK+2SKFkcP5WgFRZnIADKx6xEt4C8T8X
	gnzktuR3Y+USict2kCwJtnVz9DyEZR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750778832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoiiUm2Fj9WK2+okdYgOSWwXKVvL+oEsvy7xNbG15iI=;
	b=du7Ec+1k9lAeD6cDmfItCTSD4+6O4OIyQYsdrFVetw2b9Kyw6tXD28putC1lfSJ5Uc/Xku
	dId42Dp0uuXwQMBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vvlrnM2f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=du7Ec+1k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750778832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoiiUm2Fj9WK2+okdYgOSWwXKVvL+oEsvy7xNbG15iI=;
	b=vvlrnM2feTpV6+ta6uoKsfyvo3trinlhBI684D+M0ahVSjSaUP4cZoBGdLt58BhJywQwse
	U98pFOyfr5XwpUaZ2FENX5MgnKN3Jkq52RzP/AQK+2SKFkcP5WgFRZnIADKx6xEt4C8T8X
	gnzktuR3Y+USict2kCwJtnVz9DyEZR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750778832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NoiiUm2Fj9WK2+okdYgOSWwXKVvL+oEsvy7xNbG15iI=;
	b=du7Ec+1k9lAeD6cDmfItCTSD4+6O4OIyQYsdrFVetw2b9Kyw6tXD28putC1lfSJ5Uc/Xku
	dId42Dp0uuXwQMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B2ED13A9D;
	Tue, 24 Jun 2025 15:27:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sBX1GNDDWmi1DgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 24 Jun 2025 15:27:12 +0000
Date: Tue, 24 Jun 2025 17:27:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: sashal@kernel.org, kees@kernel.org, elver@google.com,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	tools@kernel.org, workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aFrD9wuMky8TkhUW@yuki.lan>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
 <aFqw5-PO4MjsEdYU@yuki.lan>
 <CACT4Y+Youc3M0z0U9arrTgyOC1+UKytav4zObhjUXn8-RLThMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Youc3M0z0U9arrTgyOC1+UKytav4zObhjUXn8-RLThMQ@mail.gmail.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E97F21188
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51
X-Spam-Level: 

Hi!
> > You may wonder if such kind of tests are useful at all, since quite a
> > few of these errors are checked for and generated from a common
> > functions. There are at least two cases I can think of. First of all it
> > makes sure that errors are stable when particular function/subsystem is
> > rewritten. And it can also make sure that errors are consistent across
> > different implementation of the same functionality e.g. filesystems. I
> > remember that some of the less used FUSE filesystems returned puzzling
> > errors in certain corner cases.
> 
> I am not following how this is related to the validation part of the
> patch series. Can you elaborate?

This part is me trying to explain that generated conformance tests would
be useful for development as well.

> Generation of such conformance tests would need info about parameter
> types and their semantic meaning, not the validation part.
> The conformance tests should test that actual syscall checking of
> arguments, not the validation added by this framework.

Exactly.

I do not think that it makes sense to encode the argument ranges and
functions to generate a valid syscall parameters into the kernel. Rather
than that the information should encoded in the extended types, if we do
that well enough we can generate combination of different valid and
invalid parameters for the tests based on that.

-- 
Cyril Hrubis
chrubis@suse.cz


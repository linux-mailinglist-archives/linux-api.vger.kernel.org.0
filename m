Return-Path: <linux-api+bounces-3991-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043E6AE8889
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 17:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3FD95A5C00
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB39B28689C;
	Wed, 25 Jun 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QDEbcA5d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaStM0lD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B/UY3fxb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="et7QAs/e"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ED515DBC1
	for <linux-api@vger.kernel.org>; Wed, 25 Jun 2025 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866341; cv=none; b=YHsE8yYJDSmVdiDcxcehxvqJJZe4QgnaeMNU2KZfqJ738sEV1AQ3dKfD1g2MBueGiEM6DoAzVbM2aiiTL+qCNV9z1iC0ZN45V6FqXqdKsqV9wl27/ecoxapU6wwpUNaDGXELTLl/QeBdZyKKACnc+M1fNB+tSvQ0AguPKLI8JcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866341; c=relaxed/simple;
	bh=9QaQxPfz7YtVzxDvH1uws5oTMHeE7hhnnyiamaFtpCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjFDTK9tIDT51I0lE/AUi+VP3ld/Fgb2OSib/7ylr9VUwr2CI1liycSGJgsG2NLvq9sRbvkVt6MNsDC5J5YKdgCSMYczncQ9W76Ph0LjjEcgsjUWDyTVCH8Mrl9jWNi9ESMeqvKflQkrTcwGKPGPElP+6E5F5mp9rhd70z2YRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QDEbcA5d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaStM0lD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B/UY3fxb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=et7QAs/e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 597861F74B;
	Wed, 25 Jun 2025 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750866338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6G+QEWcOCRYuQZL6MIP/s7Tu+0w9i2dxb4kc/e2U6c=;
	b=QDEbcA5d3IEtsqCnlnNfpX9BlI1fdioYeFIJEpi03MIwNm5Vly4D5uQkStIJs4S7CZEfb0
	cct920cx/R0Wy9zhOBNWfpPD9a0+H7vvyjuXqSPJp0NcJ02q2ZGyWQvsH617MmegYuVeiS
	eYj1ucTWcCxSoUMBZXKyXIfNhCRBKO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750866338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6G+QEWcOCRYuQZL6MIP/s7Tu+0w9i2dxb4kc/e2U6c=;
	b=eaStM0lDAu2AmIhDr33BvYN/Y2wN8tKTAFKhp7KgEgjDN3RtarJLSus+b8P4qp1nCSfInI
	TlhOGFGuJE4f1yBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750866337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6G+QEWcOCRYuQZL6MIP/s7Tu+0w9i2dxb4kc/e2U6c=;
	b=B/UY3fxbAwDG4cliNylU3F38jw3MhdKrfL4M643tAEbhWSAFkyGZ42MgNuMMVkmiuEzhqk
	nKBR7JDNeGbVVifF1oAqOahz7WVyKQNh+PLQ6cwZvn2YUWbfRPmfzSFAnibT/dPwZtaV+L
	lKW5hbhdHUyaSNn9+k4yhnSKrc9/G4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750866337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l6G+QEWcOCRYuQZL6MIP/s7Tu+0w9i2dxb4kc/e2U6c=;
	b=et7QAs/eFKEX/mu/ll3GBJG7zQ6/OA/YmfMEubYvyYUeIB3ROVJPZqeazU+X975cQGkLa1
	Ots/vpHOFrvIZeBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E42813301;
	Wed, 25 Jun 2025 15:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jPAnDaEZXGgbLwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 25 Jun 2025 15:45:37 +0000
Date: Wed, 25 Jun 2025 17:46:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Sasha Levin <sashal@kernel.org>, kees@kernel.org, elver@google.com,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	tools@kernel.org, workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aFwZye8vJtcoLDKy@yuki.lan>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy>
 <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y04JC359J3DnLzLzhMRPNLem11oj+u04GoEazhpmzWTw@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 

Hi!
> > >6. What's the goal of validation of the input arguments?
> > >Kernel code must do this validation anyway, right.
> > >Any non-trivial validation is hard, e.g. even for open the validation function
> > >for file name would need to have access to flags and check file precense for
> > >some flags combinations. That may add significant amount of non-trivial code
> > >that duplicates main syscall logic, and that logic may also have bugs and
> > >memory leaks.
> >
> > Mostly to catch divergence from the spec: think of a scenario where
> > someone added a new param/flag/etc but forgot to update the spec - this
> > will help catch it.
> 
> How exactly is this supposed to work?
> Even if we run with a unit test suite, a test suite may include some
> incorrect inputs to check for error conditions. The framework will
> report violations on these incorrect inputs. These are not bugs in the
> API specifications, nor in the test suite (read false positives).

This is what I tried to respond to but I guess that it didn't go well.
Let me try to reiterate. I my opinion you shouldn't really put this part
into the kernel, but rather than that include more type and semantic
information into the data so that tests can be generated and executed in
userspace. I do not see how can we validate that we get proper errors
from a syscall if one of the input parameters is invalid other than
generating and running a C test in userspace. For that part the syscall
description does not need to be build into the kernel either, it may be
just a build artifact that gets installed with the kernel image.

-- 
Cyril Hrubis
chrubis@suse.cz


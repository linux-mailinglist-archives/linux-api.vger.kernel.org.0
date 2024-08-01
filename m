Return-Path: <linux-api+bounces-2085-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59D944A98
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 13:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826671F26BFF
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2024 11:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339161957E9;
	Thu,  1 Aug 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nvBlzXEa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Ph/GSOa";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nvBlzXEa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6Ph/GSOa"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2EF18FDC0;
	Thu,  1 Aug 2024 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512859; cv=none; b=RJEVXABHNr7Ao2x2ZR/l5ulcNTv+fIPucCv/tVoci13vYr+mklcvAmDO7F0062e4jGnkd3aZeSnfjlhuO9ejU1oyalGA/ST8jHR3LREOxer7SB79+oVH/uGe74iyny7mH1/Zgh1xspoK0oGzX7+xh58q60idFFXNuZcVT+9NevI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512859; c=relaxed/simple;
	bh=2p66FrIA5VIFp3EMlll6ZjSxDDgX60/Mt0Bi0Djs02I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7S3Sbkrvr42pDm/2b69CHQ93IzorEVSjcEzOhue9Eoe/JVw6wrfMZow83QuzsVQW6OIJ//yOooEBfweJUM/3CatgaIaAFKZctrSYtVAxJ6qQcElnekp88SW8oFhSGSoJL6Ds2FKVAUdTAh1LqbIhllddArw/mkex8l/eHq2ftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nvBlzXEa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Ph/GSOa; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nvBlzXEa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6Ph/GSOa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
	by smtp-out2.suse.de (Postfix) with ESMTP id B228D1FB4C;
	Thu,  1 Aug 2024 11:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722512855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1V+CVVFrMSoc0AF1TLg4EtDnvPKvuhwL2BSJpc+RBB0=;
	b=nvBlzXEaIqUuiQDJkBfAV+n2oPVtHK//yr96/GvqozddRN2PDhFTPE7pwB/mbaahOi/V97
	rpnHZkm5vy+l1XldcsF5F/SIox8ld9iAJkkHOFeFiUyQanJ/B8/8XZuoddAhl4iMsiTLjz
	fvorecREk3BogxpTMXq2b4Lz2yJVcSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722512855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1V+CVVFrMSoc0AF1TLg4EtDnvPKvuhwL2BSJpc+RBB0=;
	b=6Ph/GSOa+4my2qscx31XcmuWmXCqO6ZhnI81TsSAqD1yE64L5kIT+dLfLMWqJDG3WHzEtp
	sWExgwD8r1TI7WDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722512855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1V+CVVFrMSoc0AF1TLg4EtDnvPKvuhwL2BSJpc+RBB0=;
	b=nvBlzXEaIqUuiQDJkBfAV+n2oPVtHK//yr96/GvqozddRN2PDhFTPE7pwB/mbaahOi/V97
	rpnHZkm5vy+l1XldcsF5F/SIox8ld9iAJkkHOFeFiUyQanJ/B8/8XZuoddAhl4iMsiTLjz
	fvorecREk3BogxpTMXq2b4Lz2yJVcSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722512855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1V+CVVFrMSoc0AF1TLg4EtDnvPKvuhwL2BSJpc+RBB0=;
	b=6Ph/GSOa+4my2qscx31XcmuWmXCqO6ZhnI81TsSAqD1yE64L5kIT+dLfLMWqJDG3WHzEtp
	sWExgwD8r1TI7WDw==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
	id 4C8374A051B; Thu,  1 Aug 2024 13:47:35 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-riscv@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-api@vger.kernel.org,  linux-kernel@vger.kernel.org,  Arnd Bergmann
 <arnd@arndb.de>,  Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: syscall.tbl refactoring seems to have dropped definition of
 __NR_newfstatat on arm64 and riscv (64-bit) at least
In-Reply-To: <87sevoqy7v.fsf@oldenburg.str.redhat.com> (Florian Weimer's
	message of "Thu, 01 Aug 2024 13:28:04 +0200")
References: <87sevoqy7v.fsf@oldenburg.str.redhat.com>
X-Yow: I want a WESSON OIL lease!!
Date: Thu, 01 Aug 2024 13:47:35 +0200
Message-ID: <mvmh6c4fors.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.96 / 50.00];
	BAYES_HAM(-2.96)[99.81%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	RCVD_NO_TLS_LAST(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.96

On Aug 01 2024, Florian Weimer wrote:

> It's been repported that __NR_newfstatat has gone missing from the UAPI
> headers.

It has actually been wrongly renamed to __NR_fstatat.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."


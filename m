Return-Path: <linux-api+bounces-2209-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9C19587F9
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 15:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F287B21FBA
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 13:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A3C18CC1E;
	Tue, 20 Aug 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XhZdDDkg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2vseWtqL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bv00aLWF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6DSm80L"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C918DF91;
	Tue, 20 Aug 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160613; cv=none; b=VyZDnyBQbxH/KmCFMAmbjxYtIImha2vs1FYt5XAZD/aQOUBF72Cinm0N+oxWGkcwpz2pkW2rdH52NB6sXC5/LpAhdFAip4EyStlCJcHO0CnFlL1Fzw/Z0UKj0MrzfWzelaKgWYaz1RvdEWq1+AG0cRKGoxlAcECLrs/cQwQjfeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160613; c=relaxed/simple;
	bh=jKlTj9khK0QRm6xc/vP87GKsjKtAJFQUzPY47Zw+Aqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FermRzaHI5CKZ6kTpCuoqywbAEM7KtWvtr7MJKH6MiKACf6QXANf2KveFC/Kjmi7oo4Zo+UGQsjq33ocQo2WvHuvHI3uidj/cVYIWwRz/rtB+zvYPh/Z91Sj23f9uNHgrFtZtFtOqOD6n3FgJ+H6a5UxGdCEZg5hK3DpJU1ft80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XhZdDDkg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2vseWtqL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bv00aLWF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6DSm80L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9022F1F83C;
	Tue, 20 Aug 2024 13:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724160609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tQIiT7gji9T0zJTAHP9wX9wn4Kb3HkhsfTfVvEFTwA=;
	b=XhZdDDkgYtVFCUrJk87/e7jyQQp7eLxRvyxI9QVIlMt/kp/ecAGw7lNO8EGRJrJ4TJQw67
	fnyz5j67bgLShJQde1udf5iLU2BRa8PFG2oQfGkWQT2RFHlUH2VyT6PRXFS/9+1Hrj5xMl
	zbwI5d4UuwsBrhgaW3mdUCmltdpFB40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724160609;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tQIiT7gji9T0zJTAHP9wX9wn4Kb3HkhsfTfVvEFTwA=;
	b=2vseWtqLm95ipXf74dNgahGePKOAK6wRnRP6CdwoCNMKv1CNLWt0ipKc3xVbZLQe5SsO4k
	ebSLjstcRSG94LCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724160608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tQIiT7gji9T0zJTAHP9wX9wn4Kb3HkhsfTfVvEFTwA=;
	b=bv00aLWFoKpU5UrtaZylkZ9epuRSUWDP3Fqq40bvnxhs9bJWqW5ayva7YGFMX8NxQGKdCw
	QiswcSWsRm8RuLwqJF1LyQBxzkp27kq3jTgqGOSxUXBoZl6fzBY0vIqKnAFTYexLjdrqf4
	pUlgBnuo2Dwr3X0vu9kJvVucj6KtjDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724160608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tQIiT7gji9T0zJTAHP9wX9wn4Kb3HkhsfTfVvEFTwA=;
	b=v6DSm80Lz8UhsXCN06dLZv49PNktl8nBVUC/G+CPA+mkTwkx9Mi2gr5ilZUAoSdRzrQTFR
	ip29Gbey290HfkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E33413770;
	Tue, 20 Aug 2024 13:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DG5eHWCaxGbpDwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Tue, 20 Aug 2024 13:30:08 +0000
Date: Tue, 20 Aug 2024 15:29:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
	linux-api@vger.kernel.org
Subject: Re: It is correct to introduce new sys calls to stable versions?
Message-ID: <ZsSaJKKyLuH_vZ1C@yuki.lan>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.27 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.18)[-0.880];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.27
X-Spam-Flag: NO

Hi!
> I wonder if it is correct to add new syscalls, which actually changes
> the kernel features, in stable releases, as it might confuse downstream
> developers because they may assume the existence of a certain feature
> after a certain version.

Just a side note, one thing I've learned by maintaining the Linux Test
Project is that the kernel version is a lie. You should not use the
kernel version for anything, never. All distributions rutinely backport
various new functionalities to older kernels and only reliable way how
to make sure something is implemented is to call the syscall and check
the return value.

That being said I have no idea what rules apply to stable trees.

-- 
Cyril Hrubis
chrubis@suse.cz


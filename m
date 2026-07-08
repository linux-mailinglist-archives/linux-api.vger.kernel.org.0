Return-Path: <linux-api+bounces-6797-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2jRPDD51TmqhNAIAu9opvQ
	(envelope-from <linux-api+bounces-6797-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 18:05:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F447286C6
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 18:05:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szeredi.hu header.s=google header.b=CfxeooCZ;
	dmarc=pass (policy=quarantine) header.from=szeredi.hu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6797-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6797-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B145B306A6BA
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 15:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79863B3C08;
	Wed,  8 Jul 2026 15:37:53 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6AD32ED3A
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 15:37:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525073; cv=pass; b=hkYAM3C6WQtEhgoJSeWxRqdj2stiJNh3Z2KNH+lrThvMw525CFGRoxrsUpRGp4AVJ4pthFlN4h6dURN6vfVSDVbJBf/wr2K+aEODwGq84UmifMIex8h0H3ndO+IiQeAcdLwsegjTQPYvO4Ji+CdUNpiB6ajyB64BERfdQVwMwSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525073; c=relaxed/simple;
	bh=WEa0OR9IElvwaCWw2siqSbeNFwXC1Rtf30r1klHV9/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMYZYVdRI5fqv/Tx6jhNEcRpgQj3JYnDtpOrGrx/K8WZB8OGGqMHJJ1gMefYkyrv5n1BLakZlsAOoGzzbGXO4IGEE94i9i9xpNydGDLbQ/AYKOXBR5JJnE4bnyJNtB5w8cBQO+y6K0RbqMXXYzj+m+hjhZS1EgPsCDQewhJdc6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CfxeooCZ; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c22c61795so5437351cf.0
        for <linux-api@vger.kernel.org>; Wed, 08 Jul 2026 08:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525071; cv=none;
        d=google.com; s=arc-20260327;
        b=iPgP/Cj267WRk99wifTuY2GPjaMCtMpRkzhjrMmcJ05pYgfq4Ka9Vy92WSScXr5Ge6
         MV9p3yWggQoTPk80AihDAiur/o11OavuPEDH6xzU/4hPUIc9mpNha/Fiyan6KbzLtPCs
         8ugTEu3EQI6igDfUqvnvRr1+xG2gNZSInuvOQ3QNIUa7Y7B86kRWAt8Unnnpijs4Zhbo
         vr53s+BFL/SV2FcLsOEiRr1cjftNDLhoz1xo0O+9D+T/mSgjhYu16vSUVkM5exgr/upJ
         /tlhLattlaX9VCkPU/UqFRBMFd4UVE0J4EZlEXz3kL/znXcrf/fBjk+UXJcUBWGBUDjG
         u5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qkeAjSrfipPZ3gYTMXBLe77/aSlGkx1MoDJPCEzD0Ok=;
        fh=nK6S5YQkApfooSrvgNOHIfHMESsgXIY/9fldQ637/Ug=;
        b=qmFjF3U4TlomolYXstnhB4mA44A6/PhxD273cEb3F58/U/jJMCcaTA8AmfQPyrJJhZ
         J936/u4hFkoEajaPX4HGlN1Id7Bo05gsCk2ajsHrns0Xdw1JdyhI+zD+etaR83jorqSr
         fKraPHKzVSeeh5LBus7hCxShZ8LVb/Aijdmt0ypsQOwl8wYU2n3Jrkg3DrMGbJrnTp7q
         uzvbKMUuDYIceZY6B9XzFsI1C/npkq69N1fmy/O3IYitveK91V83YPl2eeZP6WApxDgO
         6K/lAAUSceBp+x3ojN4I7wTgrzlIOtoRkCBCoD7GdmDAI351tG829JX2+d+ExNgJdKfG
         2exQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783525071; x=1784129871; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkeAjSrfipPZ3gYTMXBLe77/aSlGkx1MoDJPCEzD0Ok=;
        b=CfxeooCZqaSrdwi28QEVCapXEmZ+UNJ9JNHRzdjYh9wEyoLuNv8bVSqQKlXPuf4bs6
         E2Mczkycu1BZMmfcskfPLiv/3x1KoTLz9ENujsVPqj9ANro42Ffa1s+71ilozzYwtrAi
         JwbKK5HtKlBOjxiIBgiMqzuhA9ilvgig/Lo4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525071; x=1784129871;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qkeAjSrfipPZ3gYTMXBLe77/aSlGkx1MoDJPCEzD0Ok=;
        b=o1ugljwhwAcoDvTK2t86TbgDE9xQWZtAyd70NM7/ItvnnV5aiO6cKHPywKJCTA4I+3
         LEftJADFC542i1dah6QfYVz79jhdeqpZ8v+Q+NstQealZwcanaw8kmNSG+pWf1hzBo7O
         W5SJGbaqUTQqK16NQsg5+LR3pfamk0OuDhNmEdktNeD73u9RXvwnXsElipFHbAsiNfut
         j2fpmEJ8S5csmo6d41GImfzuDEU/9H1LpduCFx2ATFlfuWoaSxocOiX1kq1C8oMlWtWE
         zB+m9el0ORidfBmIs2cajmDu2EPN0W0e8IxhCL759cZJiuGgRSboHUNm4fICeJMdynG4
         NJug==
X-Forwarded-Encrypted: i=1; AHgh+Roz82RI78MuGh8wQFj06998NPlyTO/waHhO65HTjWOJBDtMo402DdDlNV0yjLNQ9hhxuhRsMIT92yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWf+YaJRopyhwz4Tf/pBSiLJTKl8fSAf4jfNWVoI2JhyVxSdWx
	VwBXaHzAFMRl03H7eNJCMaXhBQ+MLqxKuPJ7l4LvbFGbgLhEpPeBQ+cuwDlkqMz0S9vXuPSVxhi
	nGY/IVhfgFCiljEwSrk0yenm30xfPjulgJbYvlXv06Q==
X-Gm-Gg: AfdE7cn49FSdJWpKvsvleONfElRmhyfwpJfVqCd8cjrXzsJaWJdGXwq1xc9eWRVQQnI
	+a7KBK3l15JPDevIzGiisvLCNHhfPyFNzSGlxLYHjo/gI5Iuk4AAC+yuCwb8Q0lQ9SDfOyIZ3Ji
	6null+ryTFNmXhrZ0snbsjatXoH5YUK8DWM22CYXVnivXdFQkCVnXbQQ79ji7E7P6DIvyYrNfrW
	I8BG84qzPsK4P1WlRi5QDbd4LSbot76x9xTIP11B3BDaQlJLEKkQz7QbwpXGMsxRr4ynpn9sAb7
	wxXrZbOnkX7eW2R+CZiEbK5XodYgN9cDZKPEzw==
X-Received: by 2002:a05:622a:410d:b0:51b:ff78:f221 with SMTP id
 d75a77b69052e-51c8b2f174dmr33523261cf.29.1783525071383; Wed, 08 Jul 2026
 08:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com>
In-Reply-To: <87wlv57dt1.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 17:37:40 +0200
X-Gm-Features: AVVi8CfqzC9eOvDm8nHA-5UYAS5HPZI131ACQtCWE5J--FkjXHyF6qlMxysQysU
Message-ID: <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:amir73il@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6797-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,szeredi.hu:from_mime,szeredi.hu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86F447286C6

On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wrote:

> Amir suggested to add that functionality when I've asked for some
> feedback before sending the patch here.  I am fine to drop it if this is
> the consensus although I see its utility from user space.

How about a completely different interface:

int get_fd_opt(const char *name, unsigned int index, unsigned int flags);

Enumerating layers would be as easy as passing an index stating from
zero and stopping when -ERANGE is received.

It would work for all filesystems that use files as options.  No more
fs specific ioctls.

Thanks,
Miklos


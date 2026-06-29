Return-Path: <linux-api+bounces-6723-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rT9oIFo0Qmok1wkAu9opvQ
	(envelope-from <linux-api+bounces-6723-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 11:01:14 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D83926D7CE5
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 11:01:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GwU3YJXR;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6723-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6723-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 861F1304966D
	for <lists+linux-api@lfdr.de>; Mon, 29 Jun 2026 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B69C3F86FE;
	Mon, 29 Jun 2026 08:56:10 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCBB3F8244;
	Mon, 29 Jun 2026 08:56:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723370; cv=none; b=jp2p2g8zlTsn5E2cbkdyu1sf2F6Rj/HpwMsZJLOqNQe/YdZZHgrKAMvAh6E+FlnR59IIZ+CJL+ivNC+AIB/VxQFmZuGCu1AZYYMWQUsRT5yt3ZLhH1b1LnJMIWpuB5Makopb3oRad/Xb9tOoVJqcmEL0/a0CzxE6pec7D+5lEDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723370; c=relaxed/simple;
	bh=6ZpRv6SzHMXp0xQtZa31f3aFronDafFEK7j2Ogd9m0w=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=G9t25won98evbcjl0pMC1TMCU05We47J51tXgsDT47cB9n3Fec1mV5Q+TxGfYxxAQLkGUc+SBc4SnriQGyPhDc79jmZ2klrEqEHP4QrNVkw0m+OnviQf8pOxyWXA/jzlQgnZrbjCTu3Re8VMUExy/W3Ut9KdRJY9tUuod5lh184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwU3YJXR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8BC1F000E9;
	Mon, 29 Jun 2026 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723368;
	bh=MjjLfoAnCdYSBQMHU+LNPQ7Y69v0MhSYKVpOdD7ztR4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=GwU3YJXRw2/+yv1fTqnt6eVUxhDAcOuivlMebRL8kpMszPEkVDZp9KZvr1qmRJkEj
	 ndYeJ+NxyL9mh9tGB6OfPO7zUGCg3QXdX8430/N2Iysu67+wdAZgfcELi9z31tkr6K
	 Y9U1RVBXklyP6tItBZFDn3uCwDFuhK1NOepw5hw3nVpaTH/63SnR79X6vJtapM97kU
	 4oA9wlFsT8Mn2tdApNGT/6ZgFis6bRokFmsJyqXoLoH40wuVZ5jVFdTmfZXG0iW4oF
	 xcAky5dvfXqGgX8fxhaq09pJ6hXplxohoAPkJTz057yO88MJTs5krF6d9LLLvMX8GR
	 6aLMDBEccE6JQ==
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/7] vmsplice: fix some problems in my previous
 vmsplice patchset
From: Christian Brauner <brauner@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, 
 avagin@gmail.com, axboe@kernel.dk, brauner@kernel.org, 
 collin.funk1@gmail.com, david.laight.linux@gmail.com, dhowells@redhat.com, 
 fuse-devel@lists.linux.dev, hch@infradead.org, jack@suse.cz, 
 joannelkoong@gmail.com, kernel@infinite-source.de, 
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@amacapital.net, 
 metze@samba.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
 patches@lists.linux.dev, pfalcato@suse.de, torvalds@linux-foundation.org, 
 val@packett.cool, viro@zeniv.linux.org.uk, w@1wt.eu, willy@infradead.org
In-Reply-To: <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
References: <89ea76b3-e956-4232-8180-ee3929adf905@kernel.org>
 <20260625101132.3859505-1-safinaskar@gmail.com>
 <63f7860c-4f5c-4682-8914-27978b9fbfe1@kernel.org>
Date: Mon, 29 Jun 2026 10:56:00 +0200
Message-Id: <20260629-bauland-knabbern-abgeladen-c0acbfa62cc2@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=560; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6ZpRv6SzHMXp0xQtZa31f3aFronDafFEK7j2Ogd9m0w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5GStpsto3L25ZaHM588TTeVIxjm8PX36fP4G3atef6
 tnan07bdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykfyojQ/+HyQebdwRoa/Tw
 +LrZf/ycyn56iXf4+nN/F66647o+OJORYdO0TNsO1j5m20MZD44uXF/x9VjejOt+wk928kitEog
 8ywAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:avagin@gmail.com,m:axboe@kernel.dk,m:brauner@kernel.org,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:kernel@infinite-source.de,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:luto@amacapital.net,m:metze@samba.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:w@1wt.eu,m:willy@infradead.org,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6723-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,lists.linux.dev,infradead.org,suse.cz,infinite-source.de,vger.kernel.org,kvack.org,amacapital.net,samba.org,szeredi.hu,suse.de,packett.cool,zeniv.linux.org.uk,1wt.eu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D83926D7CE5

On 2026-06-25 12:35 +0200, David Hildenbrand (Arm) wrote:
> On 6/25/26 12:11, Askar Safin wrote:
> > "David Hildenbrand (Arm)" <david@kernel.org>:
> >> I think we concluded that we cannot rip out vmsplice that way at this point, and
> >> I suspect that Christian will drop that topic branch from -next after -rc1.
> > 
> > I think my patches still have a chance.
> 
> I talked to Christian and it doesn't sound like it.

The amount of regression reports that we got in short succession doesn't
make it likely that we can merge a plain degradation.



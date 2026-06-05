Return-Path: <linux-api+bounces-6560-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id poMwC6L9ImrCgAEAu9opvQ
	(envelope-from <linux-api+bounces-6560-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:47:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB2649EA5
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 18:47:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LJ5AwyI0;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6560-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6560-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F703309D8A6
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 16:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D07416CEB;
	Fri,  5 Jun 2026 16:26:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBA54A0C;
	Fri,  5 Jun 2026 16:26:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676818; cv=none; b=SylhYY4ahRluxw+hvBYjeZyRkxUzBM+Kn6duJIl8YuY2Nxn4rymNXVjUEkn+F22AuGqxI20hZ2FDv4dcjgg5vsac20dqStU2BMkaBuIxq5SkR72SkF3LBoykSWewOpkF5R+E4Jvh5zUKVEHqkla0L61bVEtDq9qolrwzF+AGJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676818; c=relaxed/simple;
	bh=k8jxxf8sPq7/nIqWVslJ63cGDL/ilghT2Ni5xc6z2d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIGED8L1Q+/9LR42D3KeujvRJSe9cl2iRi16HVTJqeLF/EOJH6XjTcEDstjDNi+ey3/mwqODhuAhKE60Fn2Ul/yv12q/tgiEv5eaiNSvT9tAf1+fiVYIIhaVj4INKGFTH/d6Jz670SC6i3sppI/O4LvxHMFGlnexIAADqhA+4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ5AwyI0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B91C1F00893;
	Fri,  5 Jun 2026 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780676816;
	bh=r2snqK5TmvBjLf7irf+fuZCEZasZ3Pbn/RhGzf37Nzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LJ5AwyI0OawYi+sL2VqoHYRDXQly81j/iq9Hu1QCyRV/oI2u+eo9HKRwCt/seMVYO
	 ZdU6gjCh3epPP4w83HFdgfua/mqbm21w206mpV8ljUXevWL42dnlA3Suzgo//DxI7I
	 exdSX9Ht4UckbFS3Yt/N7DLCSHKGx8idhu0gxBx29CuZCzwcXoJtqqrXjkIjBaxGOT
	 lrH8m8UVsyKbN2OWhs8A/Oneh86jVogUhkO87JjphEqpnAKGqdgeufNOTMLNklpySA
	 FlVFA3Q1CzPGOayBya4B24imwrQXZfdtdyUQ8YqUsnsgzWIlcrRTQJK56ddknaN3vo
	 xobc9BNb2BBHg==
Date: Fri, 5 Jun 2026 17:26:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org, netdev@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>, Aishwharya.TCV@arm.com,
	ltp@lists.linux.it, Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <1eac3b42-5dde-41c4-930a-d74cda9e6d68@sirena.org.uk>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com>
 <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
 <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g/nnWGulOH+szEAc"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBZAzPdZgEeHAtSiwJpomt8ZZgKbixuiHfRm09a4=PtA@mail.gmail.com>
X-Cookie: Error in operator: add beer
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6560-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:Aishwharya.TCV@arm.com,m:ltp@lists.linux.it,m:miklos@szeredi.hu,m:patches@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[broonie@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,zeniv.linux.org.uk,suse.cz,kvack.org,infradead.org,kernel.dk,redhat.com,linux-foundation.org,suse.de,arm.com,lists.linux.it,szeredi.hu,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sirena.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72CB2649EA5


--g/nnWGulOH+szEAc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2026 at 09:02:52AM -0700, Linus Torvalds wrote:
> On Fri, 5 Jun 2026 at 04:02, Mark Brown <broonie@kernel.org> wrote:

> > | L4472tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc6-next-20260604 #1 SMP @1780589917 armv7l
> > | L4473tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
> > | L4474tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s

> I htink this is the same thing that Christian already noted (he said
> "reported by David", but I don't know which David ;), where the
> vmsplice() writev() emulation was done as a blocking write, even
> though vmsplice only blocked at the beginning (ie waiting only for
> _initial_ space to write, not then blocking afterwards).

Ah, yes it is - exactly the same issue that's mentioned in[1], I missed
it in the middle of the quite large thread and didn't directly find
David's report.  Sorry for the duplication there.

[1] https://lore.kernel.org/r/20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner

--g/nnWGulOH+szEAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoi+MgACgkQJNaLcl1U
h9Ctwwf/XkRjB062vspvG1uidxqEpWAVutxYq5EvOG1EiujrqzC1HAdtvESiAulS
WTWxzQt+TKgaYHJ2HVDYpinhZEgTbOLChWHzER0hzObbMogvQsYUXwhn6NKNF7pa
wLasVL07aZdXilsSJdBcjzGOAkdbfpQMcPiO70YqrrCj/Dzcg3b7VDZwgWNmMJWB
ZCH7O8PaAk0UU17qB1pF7XsoK79IDMcyzwrj9XX7VqZRc2hQ3E1MU6B8vwY9QBOI
D+VetiwfTYgkb/yweZokwkAIH/o64w7mfBvi8SXnxBcKEfqvxELjjeIaD9DynXf0
GM/haoPUaOz77nGe3hZgodaEqpnoBQ==
=H14S
-----END PGP SIGNATURE-----

--g/nnWGulOH+szEAc--


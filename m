Return-Path: <linux-api+bounces-6551-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fGjdNWWuImpQcAEAu9opvQ
	(envelope-from <linux-api+bounces-6551-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 13:09:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35046647A0A
	for <lists+linux-api@lfdr.de>; Fri, 05 Jun 2026 13:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ctl1HVvS;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6551-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6551-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D120F302ED67
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2026 11:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0EE4C9566;
	Fri,  5 Jun 2026 11:02:18 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A604C9558;
	Fri,  5 Jun 2026 11:02:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657338; cv=none; b=I2RMmZE8oT3R0WBRpYGJjK1vaX2yXcZnQp9Rp7SDQGu95am3/ayuFlgrcHUWyCKTMRdzgQhxYmWO1bJ0oqKMzy5Wf6FCrlPCumvrFhojY0zYgmGVcokf2mW+d/rZPqbLJLM7Fw37vok9wUhquQyLZD51RNll2iYmBYzkwpNubIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657338; c=relaxed/simple;
	bh=2ZDtFGq2fELTLz5GfELVfngRBbhhiz0OLx9XiZhEvX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buT3CSbFoS4rRO4XX7DfEVKh6gRsEf5wU0f/kHTaV5cc68AtzhSkQp6jcGKZ/PI5LkaJ99HjygeiNC5pZE6Xue2X5aKkxYCz4CCwbMWYdSdW2XuH5GqUrlpYFH17QvlQM1b8Kf5kkZtMQjjBVxolRt5PDRrkD1hbnZ0hMZhzfO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctl1HVvS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C108A1F00893;
	Fri,  5 Jun 2026 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780657336;
	bh=zh9rGnRJpkY1lBOy/bvqPYjNbqncuR4wcG+xL8RKLDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ctl1HVvSgU76Vw6SULqs72AZrmRA3tDJG9jTF/UpoFIKpJUomvQkaONMJ0CyA9XU9
	 AkValjofDC0hU7jmySenQo7PC2jTWR++sfyBzpPIN4kFLupY0/SQ5fuOxm0sMu2UvS
	 mnw5IswfgWxzvZQmznyBKaEMmzydtp2dP/ojQV10k5/AGwyGmYgG8PseTg2XUfNaEp
	 1Om4a1nsYuMCXxy89ZtD2An6nsoOWDeNwAsM8Ep4t1ECWeFLLuev5uaXz3YkBNJ9la
	 osxrOwWtnj2IXDSpeWpSMPFEW3nhQ+w9XwUKEpCpFuARveTnsZzKfm+0ppwEhhix9k
	 UTdfJR3rGbA4g==
Date: Fri, 5 Jun 2026 12:02:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org, netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>, Aiswharya.TCV@arm.com,
	ltp@lists.linux.it, Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <d9806b34-fc73-4878-997a-95c5e8ae4b29@sirena.org.uk>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260531010107.1953702-3-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cImTK7GwRCQ+7M7E"
Content-Disposition: inline
In-Reply-To: <20260531010107.1953702-3-safinaskar@gmail.com>
X-Cookie: Today is what happened to yesterday.
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:Aiswharya.TCV@arm.com,m:ltp@lists.linux.it,m:miklos@szeredi.hu,m:patches@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[broonie@kernel.org,linux-api@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6551-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,sirena.org.uk:mid,sirena.org.uk:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35046647A0A


--cImTK7GwRCQ+7M7E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 31, 2026 at 01:01:06AM +0000, Askar Safin wrote:

> vmsplice behavior on writable pipe became equivalent to pwritev2.
> vmsplice behavior on readable pipe already was nearly
> equivalent to preadv2, but I made this explicit. I. e. I made it
> obvious from code that vmsplice now is equivalent to preadv2/pwritev2.

> Also I moved vmsplice to fs/read_write.c, because now it arguably
> belongs there.

> Note that SPLICE_F_NONBLOCK behavior slightly changed: previously
> vmsplice ignored whether the pipe was opened with O_NONBLOCK, and mode
> of operation depended on whether SPLICE_F_NONBLOCK was passed only.
> Now the operation will be non-blocking if O_NONBLOCK was passed when
> opening *or* SPLICE_F_NONBLOCK was passed to vmsplice. Previous
> behavior was arguably buggy, and new behavior is arguably better.

FWIW this is triggering a failure in the LTP vmsplice01 test case (which
sends with a vmsplice() and then tries to read that with a splice()) in
-next:

| tst_tmpdir.c:316: TINFO: Using /tmp/LTP_vmsp3vEmQ as tmpdir (tmpfs filesystem)
| L4471tst_test.c:2047: TINFO: LTP version: 20260130
| L4472tst_test.c:2050: TINFO: Tested kernel: 7.1.0-rc6-next-20260604 #1 SMP @1780589917 armv7l
| L4473tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
| L4474tst_test.c:1875: TINFO: Overall timeout per run is 0h 00m 30s
| L4475tst_test.c:1632: TINFO: tmpfs is supported by the test
| L4476Test timeouted, sending SIGKILL!
| L4477tst_test.c:1947: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
| L4478tst_test.c:1949: TBROK: Test killed! (timeout?)

As the test itself notes it's not super realistic but thought it was
better to mention it since I didn't see any report on the list yet, I've
CCed the LTP list.

Full log:

   https://lava.sirena.org.uk/scheduler/job/2831199#L4468

bisect log:

# bad: [b99ae45861eccff1e1d8c7b05a13650be805d437] Add linux-next specific files for 20260604
# good: [5e9d583f58c8b56c9f5022639ac70cb7ae6e9fe9] Merge branch 'for-linux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [a9f7db50ed2fff96727782456f49bf88def68510] tee: fs/splice.c: remove unused parameter "flags" from "link_pipe"
# good: [215701873a7ed1214bba82c8fadcd2583d0246c3] net: mdio: realtek-rtl9300: Add ports to info structure
# good: [b882d807fa443b529ae8bf917d7b640a8d555437] tools/nolibc: stackprotector: Avoid stalling program startup if crng is not init yet
# good: [835fa43a4d36bd66ad0dd052f9fa15f7bd365fa8] tools/nolibc: add ftruncate()
# good: [5d72c6a754ef488f88ad33c83d14556c6f38af3a] Merge branch 'pci/controller/dwc-qcom'
# good: [04b18289834f20bbed25813c4978833ca8bd6e82] Merge branch 'pci/controller/misc'
# good: [94bf692c483ffb325af0b110429ad37f445d40b0] Merge branch 'pci/endpoint'
# good: [1c996a37fd244d19e5dbb715328c1676e28ef607] tools/power turbostat: pmt: Improve sscanf() hygiene
# good: [083c9ab12c402efe9ed55c942ede92eb35f8bf2a] crypto: omap-des - add COMPILE_TEST and fix CONFIG_OF=n build
# good: [49e05bb00f2e8168695f7af4d694c39e1423e8a2] crypto: atmel-sha204a - fail on hwrng registration error in probe path
# good: [86ad8069366642fec18c1bc53c24cad3da720ce5] Documentation: qat_rl: make rate limiting wording clearer
# good: [d58b4a09d7f06750a706b70d068f5a678dad8233] crypto: atmel-sha204a - remove sysfs group before hwrng
# good: [34808ac8ddafc3e2c2a59e84eaab0a410e7a0fdc] regmap-i2c: fix sparse warning in regmap_smbus_word_write_reg16
# good: [dc3ec9af62a92a46378960e599521c2ac5f81343] hwrng: core - use MAX to simplify RNG_BUFFER_SIZE
# good: [513f49c33e91e58975ada7967b44512179f0e703] power: sequencing: print power sequencing device parent in debugfs
# good: [bb2d82d41894cb30d836e9796ff67d2f9a71eccf] Merge tag 'v7.1-rc2' into nolibc/for-next
# good: [07a1a6562ce29e2e0c134a57882d6e52e8758492] kcsan: Silence -Wmaybe-uninitialized when calling __kcsan_check_access()
git bisect start 'b99ae45861eccff1e1d8c7b05a13650be805d437' '5e9d583f58c8b56c9f5022639ac70cb7ae6e9fe9' 'a9f7db50ed2fff96727782456f49bf88def68510' '215701873a7ed1214bba82c8fadcd2583d0246c3' 'b882d807fa443b529ae8bf917d7b640a8d555437' '835fa43a4d36bd66ad0dd052f9fa15f7bd365fa8' '5d72c6a754ef488f88ad33c83d14556c6f38af3a' '04b18289834f20bbed25813c4978833ca8bd6e82' '94bf692c483ffb325af0b110429ad37f445d40b0' '1c996a37fd244d19e5dbb715328c1676e28ef607' '083c9ab12c402efe9ed55c942ede92eb35f8bf2a' '49e05bb00f2e8168695f7af4d694c39e1423e8a2' '86ad8069366642fec18c1bc53c24cad3da720ce5' 'd58b4a09d7f06750a706b70d068f5a678dad8233' '34808ac8ddafc3e2c2a59e84eaab0a410e7a0fdc' 'dc3ec9af62a92a46378960e599521c2ac5f81343' '513f49c33e91e58975ada7967b44512179f0e703' 'bb2d82d41894cb30d836e9796ff67d2f9a71eccf' '07a1a6562ce29e2e0c134a57882d6e52e8758492'
# test job: [a9f7db50ed2fff96727782456f49bf88def68510] https://lava.sirena.org.uk/scheduler/job/2827407
# test job: [215701873a7ed1214bba82c8fadcd2583d0246c3] https://lava.sirena.org.uk/scheduler/job/2804576
# test job: [b882d807fa443b529ae8bf917d7b640a8d555437] https://lava.sirena.org.uk/scheduler/job/2801267
# test job: [835fa43a4d36bd66ad0dd052f9fa15f7bd365fa8] https://lava.sirena.org.uk/scheduler/job/2801414
# test job: [5d72c6a754ef488f88ad33c83d14556c6f38af3a] https://lava.sirena.org.uk/scheduler/job/2827129
# test job: [04b18289834f20bbed25813c4978833ca8bd6e82] https://lava.sirena.org.uk/scheduler/job/2827205
# test job: [94bf692c483ffb325af0b110429ad37f445d40b0] https://lava.sirena.org.uk/scheduler/job/2827087
# test job: [1c996a37fd244d19e5dbb715328c1676e28ef607] https://lava.sirena.org.uk/scheduler/job/2801077
# test job: [083c9ab12c402efe9ed55c942ede92eb35f8bf2a] https://lava.sirena.org.uk/scheduler/job/2804905
# test job: [49e05bb00f2e8168695f7af4d694c39e1423e8a2] https://lava.sirena.org.uk/scheduler/job/2804997
# test job: [86ad8069366642fec18c1bc53c24cad3da720ce5] https://lava.sirena.org.uk/scheduler/job/2804815
# test job: [d58b4a09d7f06750a706b70d068f5a678dad8233] https://lava.sirena.org.uk/scheduler/job/2805032
# test job: [34808ac8ddafc3e2c2a59e84eaab0a410e7a0fdc] https://lava.sirena.org.uk/scheduler/job/2783569
# test job: [dc3ec9af62a92a46378960e599521c2ac5f81343] https://lava.sirena.org.uk/scheduler/job/2804763
# test job: [513f49c33e91e58975ada7967b44512179f0e703] https://lava.sirena.org.uk/scheduler/job/2801614
# test job: [bb2d82d41894cb30d836e9796ff67d2f9a71eccf] https://lava.sirena.org.uk/scheduler/job/2744679
# test job: [07a1a6562ce29e2e0c134a57882d6e52e8758492] https://lava.sirena.org.uk/scheduler/job/2745239
# test job: [b99ae45861eccff1e1d8c7b05a13650be805d437] https://lava.sirena.org.uk/scheduler/job/2831199
# bad: [b99ae45861eccff1e1d8c7b05a13650be805d437] Add linux-next specific files for 20260604
git bisect bad b99ae45861eccff1e1d8c7b05a13650be805d437
# test job: [2d4099641dbaed4b98711fc7d8ec94c5aec0a0f0] https://lava.sirena.org.uk/scheduler/job/2827279
# bad: [2d4099641dbaed4b98711fc7d8ec94c5aec0a0f0] Merge patch series "vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2"
git bisect bad 2d4099641dbaed4b98711fc7d8ec94c5aec0a0f0
# test job: [e2c0b2368081bef7d1f6758cc9e7edde8521237c] https://lava.sirena.org.uk/scheduler/job/2827345
# bad: [e2c0b2368081bef7d1f6758cc9e7edde8521237c] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
git bisect bad e2c0b2368081bef7d1f6758cc9e7edde8521237c
# first bad commit: [e2c0b2368081bef7d1f6758cc9e7edde8521237c] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
# test job: [7d75aa8edfce3e8ac4f0f8fe5728fd1eab8f7f23] https://lava.sirena.org.uk/scheduler/job/2829187
# skip: [7d75aa8edfce3e8ac4f0f8fe5728fd1eab8f7f23] splice: remove PIPE_BUF_FLAG_GIFT
git bisect skip 7d75aa8edfce3e8ac4f0f8fe5728fd1eab8f7f23
# first bad commit: [e2c0b2368081bef7d1f6758cc9e7edde8521237c] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2

--cImTK7GwRCQ+7M7E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoirLEACgkQJNaLcl1U
h9Bk5Qf/eatF0RmQ7gGfc55SuODXJPE8XNaHAlHHQ3iC2NRcFeVQo4pKa5flxn+O
bEVCehiyAL9Z0ny5YXd0/A9jml5JtO9l7r0RG1x0niqavPnW4K4aFhP9KJU0xZPW
kVFZWuJL1IfTvicSPh2V8kAuTxxcMC9UafI4I5R6kyOZl3b7qM/8dFUYxYo14Va7
k8Qzo8YzxS9VFsLhy5X/vCCUq9Gj5e3YC24HBEDuxmxzTV2nLlbsWc8CuTKnO8hX
2krdz5ApoZr5Z1iVR4peZphMMyHq6O+RMVltfWoO3K3U5vB6eqteU1w+yGq8WGH3
Iz1m6atckmGWCI9jlvwaKjChWGDV1Q==
=PcsM
-----END PGP SIGNATURE-----

--cImTK7GwRCQ+7M7E--


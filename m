Return-Path: <linux-api+bounces-4635-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D8EB38EB1
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 00:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD3E1BA7DB6
	for <lists+linux-api@lfdr.de>; Wed, 27 Aug 2025 22:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE62FD7AD;
	Wed, 27 Aug 2025 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="cOB8QIAs"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B720530CD9C
	for <linux-api@vger.kernel.org>; Wed, 27 Aug 2025 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334919; cv=none; b=tUOIn4EwlQXr/xfbT3hMJGOJuQykYf5K5uxqN7Fo+lfsieDdJ68YH5ZK75RPqR1nT9Oy6qGXaErllPsYQ2j5WStGSSMh9YObSQcwA0xqSEAS8YlZnZ8WfdQj8FMyfTlV3ZWPGdLj8FKRfG9rHUy3+mK7YHtwin0+hWRUl7R54xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334919; c=relaxed/simple;
	bh=71iWMcF9pEUGi/oDLMLq3jMCSULtJZKM09xNMTqc+vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTa7+B6qEsqWwTg4F2IK5XOi+uP1mjlmp1ZbEBCqKhdxjaYE730hHVKmBDvPu1uPFPgbNmldJKEY6f9lMW4hcdqlUy05+yZmtEtWFY7QiUeenovdi5q4WVHLoAcAjHRCtv8jt3CsUi8ee56dHBbwwjxe7FwXbsGXb/brP8FXKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=cOB8QIAs; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cC07P56KGz9std;
	Thu, 28 Aug 2025 00:48:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1756334913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=71iWMcF9pEUGi/oDLMLq3jMCSULtJZKM09xNMTqc+vU=;
	b=cOB8QIAsq0sM2zFjtIYtm0HTsgKjueYO9pEffox496m5Cs3jBw+R6lmEXTUBA6ijTNq/DH
	2H86tCpIjLuDqGIMUCzPuNNYGv/u8UFNHKlKUbVDACSNPPDO8tD1QtpitLpdzlCIbAw1dL
	h9LT7H+Bihi58mYAxly+lhanEW/qgCUAOtAO9/jKQse0PyW56c4V/yE1NMUTJt3pnxIGkV
	nydKjWA0wJBW98FFDMNSEbPp6XJQqTKYrrJE0tY2J9AFMQNu30O/+lbeYbv+93fw/xLWRw
	RfIMX2bPBofyiw5bW/F/CAbq5tLYBTlzQr2fz8tygZchae4TLDQLnIs30f3EFg==
Date: Thu, 28 Aug 2025 08:48:22 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Arjun Shankar <arjun@redhat.com>, libc-alpha@sourceware.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
Message-ID: <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
References: <5d4eaca9-930c-4fca-bdbd-5174733642ee@cs.ucla.edu>
 <b34176ff-883b-4a3d-b48a-8c6421f53ec7@cs.ucla.edu>
 <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org>
 <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu>
 <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu>
 <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cnmles5ccyo4hg4n"
Content-Disposition: inline
In-Reply-To: <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu>


--cnmles5ccyo4hg4n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
MIME-Version: 1.0

On 2025-08-27, Paul Eggert <eggert@cs.ucla.edu> wrote:
> On 2025-08-26 22:58, Aleksa Sarai wrote:
> > Personally I think both approaches are less than ideal, and having rich
> > feature flags for the entire system would be better but I don't think
> > this is something that would be feasible to apply to everything in the
> > entire kernel.
>=20
> Agreed. But I'm not seeing how a hypothetical "give me the supported flag=
s"
> flag would be useful enough to justify the flag.
>=20
> I'm looking at this from the user point of view, and it is not ringing a
> bell for me. Granted, the current "try the flag combination you want and =
see
> whether it works" is not ideal, but it's accurate (which is not always tr=
ue
> for "give me the supported flags" flag) and you need to do it anyway
> (because the "give me the supported flags" flag is inherently inaccurate),
> so why bother with a "give me the supported flags" flag?
>=20
> Here's an example. Suppose we want to extend openat2 so that it also does
> the equivalent of statx atomically with the open, to avoid some races with
> the current openat/fstat pair of system calls. Under the approach you're
> proposing, I suppose we could extend struct open_how so that it has a new
> struct statx member, add new flags to be put into struct open_how's flags
> member, and programs would be able to query the new flags via a "give me =
the
> supported flags" call.
>=20
> But in this scenario, the "give me the supported flags" flag is useless. =
If
> I'm an old program I can't use the new flags even if I detect them because
> my struct open_how is too small. And if I'm a new program I can simply use
> the new flags - and even if I tested for the new flags (with the "give me
> the supported flags" flag) I'd have to test the result anyway because
> perhaps the new flags are not supported for this particular flag combinat=
ion
> or file.
>=20
> What specific scenario would make the "give me supported flags" flag worth
> the hassle of supporting and documenting and testing such a flag?

"Just try it" leads to programs that have to test dozens of flag
combinations for syscalls at startup, and for many syscalls you cannot
"just try" whether the new flag works (think of a new shutdown(2) flag,
or most clone3(2) flags). What you end up having to do is create an
elaborate setup where if the flag works you get an error (but not
-EINVAL!) so that you can be fairly confident that you didn't modify the
system when doing the check. As someone who has to write this
boilerplate whenever I need to use most system calls, this really
**really** sucks. In some cases you can just try it and then fallback
(caching whether it was supported), but in a lot of programs it is
preferable to know well in advance whether a feature is supported.

A simple example would be mounts -- if MOUNT_BENEATH is not supported
then you need to structure how you construct your mount tree differently
to try to emulate the same behaviour. This means that not knowing if
MOUNT_BENEATH is supported upfront causes you to redo a lot of work in
the fallback case. If changing id-mappings for mounts hadn't required
adding a new syscall, this would've also been an issue for programs that
needed to change the ID-mappings of mounts.

Some kind of "just tell me what flags are supported" mechanism avoids
this problem by telling you in one shot what features are supported (so
newer programs can take advantage of them). Most systems that expect to
be extended over time have something like this, but it's usually in the
form of string-based feature names (/sys/kernel/cgroup/features, for
instance). I wouldn't be against such an idea (if we could actually
guarantee that everyone actually used it), but something similar was
proposed back in 2020 and never happened -- CHECK_FIELDS is a very
simple solution to the problem that works for the most common case and
can be implemented per-syscall.

I've added linux-api to Cc, as I'm sure there are plenty of other ideas
on how to solve this.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--cnmles5ccyo4hg4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaK+LNhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+3sQD+Nvo9cc2bBMt0ImcO7kki
QSj222naJ9xmFtBXcZQ0uu4A/0oTk6/zqk3EgGVtrp08l/bdMAq+0cwHZzN7LHT9
8qMO
=YRP7
-----END PGP SIGNATURE-----

--cnmles5ccyo4hg4n--


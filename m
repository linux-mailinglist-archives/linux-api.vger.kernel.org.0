Return-Path: <linux-api+bounces-6348-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AM6Lsw+C2pQFAUAu9opvQ
	(envelope-from <linux-api+bounces-6348-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 18:31:08 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10F570F18
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BACF8300CB2E
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF18135F5F7;
	Mon, 18 May 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="sDzmeIi8"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDF265621
	for <linux-api@vger.kernel.org>; Mon, 18 May 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121377; cv=pass; b=IQfvJZ18va8eTQXkZu7+JwlG4ckE7XrnqkYOdd8z8tRXws0JwuTW3kK5GPOEVpT3FdQ1L3WZ/eFnPZk8wA2AZWImKu7AJ4U9kMNEgnWPNEM9kmFK2RiDCcSwcTJuYWbkSBwaq1Hpe6izdGhDbEIwWRR0WGoSNV61rvRNxPj/Kgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121377; c=relaxed/simple;
	bh=XTFNVsqBQzn+UexOBPiyxjDehU0C6sH67ZUr5pWq79U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McWCgfuxuudL9633e1DWQurSAoHxUNArPy6uE1K4QSUtiPfDROKEzQGFqCnyPJ9FFeF8d7pwDVXa5L8nLl/zjSe5ym8MRCtxap9qDMOUBSgw92pRr1NTM1Tzru8hhtK301ehaoKf9YtPX/jHv15c5aTfpceZP++KeK1lrIAonlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=sDzmeIi8; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40502e63bso2731791e87.0
        for <linux-api@vger.kernel.org>; Mon, 18 May 2026 09:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779121374; cv=none;
        d=google.com; s=arc-20240605;
        b=fXP5QR764x+DclLUA+jN3uCSXuNVegvSx4zCZyKLSzucmyNI6JsGsLIYOqI0WYGGJz
         llUs8cvYkDggGzxHFjaK+adRDz7LyVHerqfICutkKw8k/0DFfPmV9jOMDxkzVHazUXSX
         dX++2I3qX76WWvDokSa4y7LuZyhsAoVokKo1nXwUTE66Mfssr9c4CJHtrfFXR9sVjWwY
         z9R/h9kWISlaVjCkk3RTObj3bGcq794i62knmj7sS+H0NVJygH2ntds46nJzlzSKnMev
         jFUfOPBoyH3N6KqCvTV/MuIptRyMjrrrX2Wkd6rrotHDh9SnmHs1Em7Ae/Vjc5deArEr
         55Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GBfJSJU2PEERmOqNyTzsxNh3P380LCp5dFjg7jcTh8w=;
        fh=F2RyuIcTtKWKHAZTrH+Uba/FEW4liRDKkI9PCLfEuYg=;
        b=YLN02wjvf84Ax0juuwDuQVStHJio6jOOsNU20wD4D80jFCFzPL1I/5BvhNlKIUU8nf
         4tSgUj+gcsuBOGxJjVpx7yZfiIlflSftfjL9gGISepZp9/4Jqdt3P3TlTe4PuANGhwXs
         MeLkv5RWlAq5kWBQ1FgqVE1t/iFgCC1vRt5geMVUuDr9kbnZF5vOc+v3T1/LPePu+P6b
         cQBDpurXmP1UczBGvprFtSSQMbJSSjxlOLDP1ziixLB2+SCTDGBtypdToi++yBXdTcs9
         PhA6sUHEDuhdPW/86nrJacN4DbHgOK/T7tktxb61qXIAMDFWwrDM/vAFjTZJjvv0TdYY
         oe2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1779121374; x=1779726174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBfJSJU2PEERmOqNyTzsxNh3P380LCp5dFjg7jcTh8w=;
        b=sDzmeIi86sejOQvOoxvX4DWMLk3RAsUAuuCOsTHhu1w08vWk2Y1buzve/Nxd/EaOpX
         RQlGqsceYvjNqtC2SUoc396Y/EnJUmezIyWvEoSFpBk7a23Jf/hBVDB88mb1ChJf2r0X
         OEft0J+QmQ70qyR2bH6J8vL63B8KyYOTD6XZKJzL4eDxnOMRI9xP0E57cNx2evjRKTRQ
         TjbxfaXdei73OBPGe40uaTLvVP5ddWvT5cQc/hZLQvJG9rBED9mFYB2GZoAO8KxmOuwd
         TE1bMb7cOltQ+tUu9kTVNG7ciUrE74SZKrLR4jhiXTh9Z6oJzZX8sgp3+thJkMsJgSP+
         HV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779121374; x=1779726174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GBfJSJU2PEERmOqNyTzsxNh3P380LCp5dFjg7jcTh8w=;
        b=SDqEd6FhT0XONJgvudbaTztFqB4GVKtWVCc+97XMkGROXKCwaV6u6XcGR5pO9GPSLY
         wxNzCwrTKYxPv5KihU+oH7a4il/90D6J7CFRLL/Iah6zV7TYIA8cVt8Vp6+HfdCAXGkw
         OLubrf0NNR1Sm0QX8KE8kobZwXCjtW9qU9Ta7dUc9nxD0yIqacBgL6GLTvpCF9jjYWnk
         +wfjOVs3OnbFsEEmBoapOdB+A70aLlBGQqMO718BM8lreQycHCF3z3lsIP/WrCv0/xOL
         ZhxeLKBY243lro5wWGL5FBK7434vEKoDoInmLvftC9Qb8vlkALdd5XP1LKEptVZc7Hgg
         WddA==
X-Forwarded-Encrypted: i=1; AFNElJ9lBEHf65O6inwrWiHyYifjRhCLWjq581fh0lcMdMUabD2L8VrXMvZ0JV5RzHprDkpVqQyGLxWZZdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx84g2la177HOXVzIqA1gY2HIt58IR8MSp3EtFkQ7s+1CknA8H9
	fY7goWUsx+VbSsvNA29zlF++Yso5dUuYPoxGNjKIqi8QZAofmB3nII/a3J5fPnkCC8h3MeQ7AfH
	QytrYB4dcEkXzLw2OZEvo4R6GpHzlQA0xLtNNS/nz
X-Gm-Gg: Acq92OG+1xBtwHCQ8mybIaY2gwNC7NQGkZhMCyl8s8j2qHv/gMGELeBzHqoX/om+5Uq
	h2gBDf+/6qTLtRCCK6MQQs80OTqg7n/OS6QzVIEXPfsRvM8XFFbfbrc7jJb3ORZsWccarX9J4Ti
	HhnNAdeUXoyDxOV2o1Q4HTElxwloZWaiJ4Cx+vXdc4LxtyQyIYr8XLfSyJ27zBi0Sqyp6pTcQiV
	MhxVVj+CIIRepDmFRCEBmo/KuS1yckSIIIfzBUzKJ4CDksNwlrU2Xmc5kYvlt2cllQN2ESb7zqV
	xmlMFlj/KOMWZp8=
X-Received: by 2002:a05:6512:401e:b0:5a4:74e:5f75 with SMTP id
 2adb3069b0e04-5aa0e60b1bfmr4415283e87.1.1779121373933; Mon, 18 May 2026
 09:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org> <20260518162048.GC9531@frogsfrogsfrogs>
In-Reply-To: <20260518162048.GC9531@frogsfrogsfrogs>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 18 May 2026 09:22:42 -0700
X-Gm-Features: AVHnY4LPlnFdM4Ytr497DHglr7id-JLbay6wfSP_dcQx5-R5dh4Wh_ZPGa6qlGc
Message-ID: <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com>
Subject: Re: [RFC] fs/ioctl.c: FIBMAP requires CAP_SYS_RAWIO while FIEMAP
 exposes identical data unprivileged
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Cyber_black <Cyberblackk@proton.me>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Mark Fasheh <mark@fasheh.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[amacapital.net];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6348-lists,linux-api=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,amacapital-net.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5D10F570F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 9:21=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
> > On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> > > Option B) Add a capability check to ioctl_fiemap() to match FIBMAP.
> > > This restores the intended restriction, at the cost of breaking
> > > unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefrag).
> > > This option is a larger ABI impact and likely undesirable.
> > >
> > > The preferred fix is Option A, since FIEMAP has been available
> > > unprivileged since 2008 with no reported security issues, and read
> > > access to physical block layout is already implicitly available
> > > through open() permission on the file.
> >
> > No, FIEMAP really should not be available unprivileged.  So I think B i=
s
> > the right thing.  Can you send a proper patch with a proper signoff?
>
> For anyone who might be relying on FIEMAP output to find sparse regions
> -- don't.  FIEMAP is a lowlevel fs debugging interface; it won't tell
> you about dirty pagecache backed by unwritten disk space.  cp was burned
> by that a decade and a half ago.
>

The only way that I'm personally aware of to determine whether ranges
in two files are reflinked to each other (and the only efficient way
to find identical blocks to, say, archive a large directory without
reading all the contents) is FIEMAP.  I wrote some code to do this
awhile back (not in production use).  Yes, I realize that it might
have issues with dirty page cache.

Is there some other way to do this?  Could an API be added that
efficiently answers the actual question without revealing information
that shouldn't be revealed?

--Andy


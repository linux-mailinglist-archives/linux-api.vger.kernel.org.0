Return-Path: <linux-api+bounces-6361-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCsDD3vNDGrAlwUAu9opvQ
	(envelope-from <linux-api+bounces-6361-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 22:52:11 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90BD584E0F
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 22:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3CEBF304BD17
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 20:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6F3B38BB;
	Tue, 19 May 2026 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Nwm8Bjdp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C83BB670
	for <linux-api@vger.kernel.org>; Tue, 19 May 2026 20:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779223929; cv=pass; b=SK0vw+qaT+6GIW6xesVZ818ykqJfIj0ZiAi3Rx641dk852XJ7XJBxIS6yp61VPFFlauM6Sev8lHLpHio+LqbE+5W6tLP8VSh1fbPHdbqXxRyMhhmDrggjoyzzyNxSB5ljKJjgNOaBW6ZtL9rffEJlorQZfWWOantUKX/Q02q6EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779223929; c=relaxed/simple;
	bh=yc0dQk+734JZ/guiyL5ZplibEbSlVTH5WIewmxvfM8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrpToKrwLBhusUvnKjxoiOc+a1cZAtJNPbF7LzEbMMGRw0qqCQdOjvz/dKOIkY2qcuCmloZTb74KcoXv50xr4J8eDRKoJnM/DJ/xNnkvNNH7QYsMyDAnF3HzeFd0Os1QVpkIUCFVFylEuTNvkjEJwyl8OxrxFTDu4UrQiZvPP10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Nwm8Bjdp; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8ee4b703fso3959592e87.0
        for <linux-api@vger.kernel.org>; Tue, 19 May 2026 13:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779223926; cv=none;
        d=google.com; s=arc-20240605;
        b=LD57Ce7TDDqKBk2lzLUyF+TkBwM+z+W+acx+NUwsfb7mvxL3y+pf3Fe48OimU2eBJY
         tQU4f+Ix+IOb3B4WUyGT3LkQb5v2Xv1LGiZ2vhJFOG/HtDjnUYl8Z9vvn2tCwp0Wmhi2
         /TnXmUzTxze6Qhc6jzpEOHQidw4SnzFMiCi8nIefbRQDFnG4AsOqbAMm5/kUV5aFmLTS
         XbxjISeN8G1Bu4SVp3wh1L2mlGpbzJBHAboi/mfHuyt2zuIMQKCm2c0Dh+bJuJL7BCbJ
         uNyLpOIRNshpAIIgwULgWb9u0guc1niI8pguS8bB4MP9qY8VxIxNTKQlIVHo1nf5eZWY
         uMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ij0xdcuLSgQ3aowYuDZpEYrT+iRvJ+RmX9eaZmmPv6w=;
        fh=eCHptD7zvLuRj1tq/2wqCn5XmSc9xgwh2FysMv0xAx4=;
        b=gFZJICX9N+VVXUI36EIo4cnEnRgoaSA3lZjabKDI7es4O3p17opqDkPSVwgxMPqxK9
         evuL8UHc4ZBVlQtNvlvCMCVoT7H1xbcMb3HTZY7ika904fcwnrv6vitzWF2I5mWfpt55
         6VPipuEHx2J6xHaHbGQTlsUQL1bGp0twbzqSlQCiE1yx/NpQj8XooFIuUD+cnidXDD1Z
         gqKJa4nVTAnbTyRZnlLuIVV06xAijje2LdG3cWQ5v8lBZ0sl0Jq23vFGfIxwCMUvQodH
         vxUUWpLwUUgoNpjrBk55gqBEmCPo8Fr+/cxtWcOEk+GXqI6d3PrEx6KvPdkQUGcEcK53
         BwSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1779223926; x=1779828726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij0xdcuLSgQ3aowYuDZpEYrT+iRvJ+RmX9eaZmmPv6w=;
        b=Nwm8BjdpMzDHul6LS60KpJKBisL4tcUb/E1ynDBAMWt7sE493fnyYlS3HN3jSz+nX0
         f31CkVEzr4IGl+0D6BcROQxy1Msw/Q7jBhzEXiOWvpAE++W7SPOIYgg6ALtdI5fWAhfp
         NExzjKxc39kZvg51iOTH0tZi0RQbTQAJLH8M9RsqukFiyb/tx/rgc0TrfTvcXAZHXO31
         rCgMK2F5ceA3niOOxrKL4gWtLB0hB1Lfzfkvv5XXsjga9M67nmOHkySECMX889zbxyKE
         9Zfopof5CPfpR9H1GajFzmmetog/9KU7WqpNfYXkoaXWxmx7ddNyhxyR1DSUCnNhUG8U
         ILOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779223926; x=1779828726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij0xdcuLSgQ3aowYuDZpEYrT+iRvJ+RmX9eaZmmPv6w=;
        b=WmNpaiS7U40Rt5AcT6HsAOS2CAKINSYUYbBi2ge8a56bH598/e44RuksHArstYwNEO
         svX+/XE9FrFkO7qwACLxkytK8IC05gASIiQesvaX7DuOjz4CJjtnoCHoupSW+ZEnlyZZ
         0+ql10UGHA76SI2lcQ1YmZJlZpTO8uYkLxIPIRaHUWv/S8Vmf4ohJEwEL4cZ743ldp/f
         /cJNd/e0tKuQUMBvURpmG9+PQYUIMLDllbJAEd4wRIm9wegB3Fy7I4XpqgkQPaFt2Sst
         Fa8p4HvS6pE8YsmZtzN0a2KOxEVURU8k3DMX496ylqYU2luTFcbdgu/7XKZ6p5iZ89AX
         ShAA==
X-Forwarded-Encrypted: i=1; AFNElJ/vSlqZyvWP0tDRmTwHbvUno2AdQR4nYYPCrIRrq6atHD4K0EMrX5zR6HvhtaH2DG2wczlJ1WappRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfC+jqsN+ErcvYPnMvqnquuOBBla5aTUsgI7upbr3zNahRX9Tg
	GYKgkFlgee7WcGuX/NZsT+E9MCNPyXJN7jj2mVjEucR3cbi314EpMb/saARwpRA/QFL0KbPUFg8
	92NX7NtxjWEKAIQdqQ2Q9KDO01gN6kRaoQ3sxP/nn
X-Gm-Gg: Acq92OG6ISxFF/+ju9ZpfPs0+/5E0JRHACBNLpmSBtaqsLwBGDlguKmxMxTOijVXpe4
	sErzKS4H5kJ93VWEZL4Q0hvIvsWOa689/+UTKw0K/8gG2Tk691cjJI979UiANQp4cCnMLz/NoG7
	p8Gu1zBDxMtNN+tiawttmJPLWDvsxr8HO7tWL8daL4gydtgutdfxL+sumo9G/qjgt1F58i+pI9L
	nE/Q4+XhiVSkDz2B5hA5k+4IPPxX7RqZngyDmKprKYbDDy4sUzixwuz+IVM6zDdah5TiSwq41ge
	5PsLHSR8EvJp2IYuaFXoZgnnjA==
X-Received: by 2002:a05:6512:6d1:b0:5a8:52e0:7bc5 with SMTP id
 2adb3069b0e04-5aa0e7450cdmr6553274e87.27.1779223925489; Tue, 19 May 2026
 13:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <_fcorj7Aa0YnzUmrPnqdEbTjLqS6S7t84HKrzsswvKm71LC0uVmTD2cthCwpgeI-296unEpzPZYBNdFFDXjsQvZRtGfTaQlKmcRkiSI4wiQ=@proton.me>
 <agqevS--YYBVW2Oz@infradead.org> <20260518162048.GC9531@frogsfrogsfrogs>
 <CALCETrUFMFNnJ6FLd9SkzS5E1q3x+cqGvOvo5PzU2V_+moSEJw@mail.gmail.com> <20260519033126.GD9531@frogsfrogsfrogs>
In-Reply-To: <20260519033126.GD9531@frogsfrogsfrogs>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 19 May 2026 13:51:53 -0700
X-Gm-Features: AVHnY4K1ndQwPwy1fKsG8m_UaFGF1PGZ35IpcHSt6y2mDSPDMZHvPLuBjSgucKA
Message-ID: <CALCETrXWuMJstpkDhV4eKTwbRhQAQ0RZTkkFN=+oXrkiShgx1A@mail.gmail.com>
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
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6361-lists,linux-api=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C90BD584E0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 8:31=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Mon, May 18, 2026 at 09:22:42AM -0700, Andy Lutomirski wrote:
> > On Mon, May 18, 2026 at 9:21=E2=80=AFAM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Sun, May 17, 2026 at 10:08:13PM -0700, Christoph Hellwig wrote:
> > > > On Fri, May 15, 2026 at 05:36:45PM +0000, Cyber_black wrote:
> > > > > Option B) Add a capability check to ioctl_fiemap() to match FIBMA=
P.
> > > > > This restores the intended restriction, at the cost of breaking
> > > > > unprivileged use of FIEMAP (e.g. filefrag, btrfs tools, e2freefra=
g).
> > > > > This option is a larger ABI impact and likely undesirable.
> > > > >
> > > > > The preferred fix is Option A, since FIEMAP has been available
> > > > > unprivileged since 2008 with no reported security issues, and rea=
d
> > > > > access to physical block layout is already implicitly available
> > > > > through open() permission on the file.
> > > >
> > > > No, FIEMAP really should not be available unprivileged.  So I think=
 B is
> > > > the right thing.  Can you send a proper patch with a proper signoff=
?
> > >
> > > For anyone who might be relying on FIEMAP output to find sparse regio=
ns
> > > -- don't.  FIEMAP is a lowlevel fs debugging interface; it won't tell
> > > you about dirty pagecache backed by unwritten disk space.  cp was bur=
ned
> > > by that a decade and a half ago.
> > >
> >
> > The only way that I'm personally aware of to determine whether ranges
> > in two files are reflinked to each other (and the only efficient way
> > to find identical blocks to, say, archive a large directory without
> > reading all the contents) is FIEMAP.  I wrote some code to do this
> > awhile back (not in production use).  Yes, I realize that it might
> > have issues with dirty page cache.
> >
> > Is there some other way to do this?  Could an API be added that
> > efficiently answers the actual question without revealing information
> > that shouldn't be revealed?
>
> Well, yes, we *could* make yet another ioctl, but we could also just run
> fe_physical through a one-way u64 hash function and set
> FIEMAP_EXTENT_UNKNOWN if (say) you don't have CAP_SYS_RAWIO or
> something.  Then your comparison function might still work... maybe?
>
> OTOH nobody really wants Linus roaring at them, so we might all just do
> absolutely nothing.
>
> Also note that FIEMAP still doesn't report devices, so you're still
> playing with fire on multi-device reflink-aware filesystems like XFS.
>

A hash would be fine for me.

But really a nicer interface would translate logical ranges in a file
to some range identifier, where:

- It would be consistent with page cache.  So holes are only reported
if the current logical contents is a hole.
- It would return reliably different identifiers for ranges that do
not have identical contents.
- It would usually return the same identifier for ranges that are
known to the FS to have identical contents.
- It would not return the same identifier for files on different
backing devices that just happen to be backed by the same offset
within their respective backing devices.
- It would not necessarily return values that are consistent across a
remount.  But maybe some kind of mount id would be around to at least
detect this happening.

Fun bonus points: if the range is dirty in page cache, tell me, and if
it's not dirty, then, on supporting filesystems, return a value that
will *change* if someone writes to the file and it get undirtied
again.  IOW it would be nice to be able to use this to efficiently
scan through a file and see what extents may have been modified since
the last scan.  But this would be complex.

I couldn't care less about the actual location of a file.

Anyway, this is a bit of a pie-in-the-sky thought.


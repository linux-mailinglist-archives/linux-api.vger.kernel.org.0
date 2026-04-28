Return-Path: <linux-api+bounces-6218-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNdQEnnZ8GkLaQEAu9opvQ
	(envelope-from <linux-api+bounces-6218-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 17:59:53 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F34D488628
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 17:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A97D230C51E8
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2026 14:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A54F3B9DBA;
	Tue, 28 Apr 2026 14:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D08mcnP5"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597337C904
	for <linux-api@vger.kernel.org>; Tue, 28 Apr 2026 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387164; cv=pass; b=kJhLKHAI7fPQZ4SU3eSjGgDJTKvH0MwYn/Jzrg7EgFTo6pYo9L7Nr20hIer7y9nQeHG6JUxkURdjNsWcoYG4/t9kO8xhJgnfXRCiufZc6KW91uN5Am8NDBghGg/mX/pgIb0N2/1cIkhH8OtYbL22Sd+ZSs0Y3yBdgRiwAbdBRkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387164; c=relaxed/simple;
	bh=o5yp/O/UpJT2rk9hPW1wx6A8M3OZah1AeYGoao4WXUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qpniL5tE7HDrNBqhjATJ4vzwr06TGlHtLjWigwYkAQ3xhGCIBXuxCJYANOFgL4Oa2Djb23gWR2iHheWD+w4r3kVJbIH7kHr6qmZLUlzlzyr6oWHYp+9sPoc4DTlwoInq0zs1kXoVFtQpWDTQLno3mAQJvma1P98zOpodG2Abwts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D08mcnP5; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so14238856a12.0
        for <linux-api@vger.kernel.org>; Tue, 28 Apr 2026 07:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777387160; cv=none;
        d=google.com; s=arc-20240605;
        b=Lvkwm5DY0pHaQURuGxWFasAd3tp/P7z6fKuL6nJBKYRhrENWeWkY0HGdV9+YeGkEPh
         smOgAqZdoRCNaTHONhqQD+KPRn2vtrI+vT3aPdQDXqYayarVjDUQNHpgsWVo5vf4En97
         KxblvD3ul+Y5jvGIOIxZVlP8DKRuGnmsnlZZethOoloHem54YHT1TPcG+zX5nWO32nbO
         e2lp9uWvwXlKnLgf3jo/bmsyF+rUILPxlmU9vM/ZIm1/vy9io90rM3mKlkR2iaGDEh+w
         juxPbbWbq+CbhACd2VVr21Exh1OEhL9Ymx1wERFZ5dKAfjUqN2TdXehSfPBdWUjtSi48
         dSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        fh=B75IQUSzA9cVGl7fmUKPlnk85YbCVukTNKkuWkWKk0E=;
        b=eBtjhyKVuVhGktS/WBX53ptILHNoDEOn0JO+gG+DUJ7OZ8YSDQqyd31iq01P3pFYEn
         Yap+diQTSo5y4Jf62JMDuA6I5lxQEPAPHX8u8USz3LgP6vQZ9VQ0K6XQOfqD85xI96EU
         4OyXbgPSIKGeYbK5vY3on4+qYAmfQ6t1Y/RtptlVp+x+owqxr+YomPpmzIiNI+yOQm12
         AHc7Klrx90/l5WELZlfJdAGA9+6Ylhuo5G1JZCzKL+2DYRZYJbGTD3l/XjsRA3Vgu8ZS
         62k2MaUtjFpLIzb+tW45eEXoEzAUFWwXVirKHmWmYVvLV8ePQELRfTuE7KXBHSPvjx/s
         LFgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777387160; x=1777991960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        b=D08mcnP5szl+13rSRXOE9LH8Qc4jOlJdFOrsL3d5rSmnIWRl2EQMMdhsnQ0VzTI/p3
         z4PFNZ5PWDzow9X4xtOVmJ7h8xY0taALshxRAZgUAXxUnrPyzwznZnbvd4s6vw1ZMM6b
         RPW49w0al36ig6M48MBi5BStjBbzdVz7aZgP68JqJLlhU9A5sfGD94dDZQ16MYRL3CKV
         95i3ALKLBMRxxh6+2mNY5OVwSQJM21tiKp8PbiGWcwtHYZFekNFUYDVwlMVtnBTsYye3
         8C5raITCLyi1C17H3EmKSreZP8jOcMvv55fRU1wY4BkTUxCjWwFtpyEZr7Xky/75i36C
         ZUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777387160; x=1777991960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PN1B9vhJycrgbEH0DOyhYXb0qxN2cniV/ZcL9J2GD5k=;
        b=dAineUwMTa+1d2aFF5R+eXN2YClZxiQOFL6CQGljq16sKfE4cTDZI4GpgNXcxbiCmq
         eZlrBPd/JM7wrzIF030n9x4bh38JkrdMJGIBgNx1wVnpTNS2WMG6F+EBLDaRzKFYFS/x
         /UDC+rNZiPoiPu0Z3yalFD50Yul9RAtjSmJKGCkXfFDTpudyepD6e1RTUNGdCBd6+3tX
         LYYb87qj7/iBRqog4DJVagev2uZDpZkWqjOSQqgAaQtSTa0jbxMfV2aUg4vc+EAuY0bx
         VTy/hna5zQrSVrE4m9nPw02ah+u++ZhurZYLa2bZ8Lo4SCv9SYosEviANkTL9waO54Hl
         xTwA==
X-Forwarded-Encrypted: i=1; AFNElJ85+UoP93QYGh2wkG9agFB+wzHggLaMvrDKrGbx4V/O86JnNhOGtMqYM9vIZWUgfz2/QNXF2HueEgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrBBMOAkShX0czUEex9ksKHAY6kIK5o6tGhnpw22UTW4cac+tv
	STXGvyM2QXlkKNHnn4vqBqjsrbLgQTht1AgZzF9GnsIF1SD/5XraspczsI7voJoLtK9AE1PSzLz
	EL0r75RGoKbSykdrCClcqEB4tAPySIrQ=
X-Gm-Gg: AeBDievYh/NjizGPBPrNxaEc/SKJV//zpM41anYjTxLm4zaHI56v0f0lNkFpfUZVEN7
	NgGNayHTD8D0daU0Br0stZqSgN3yhPzLEMJRgvYcYAnBPlnea2S4fg1GNKtKVx+RMpDGL82n+wa
	NRx98f8GLTH97K7m2kkUCfB2soF+j6iP0rlq0fUy21uFltWvK5yILoODJH5EOt+iuxtTn/hjfGc
	y21hnBAfpDUChGaZ7pSJR6HeNEX/p/HkQhoJsWsNpv9XtUsvxr/Tiu9qdVF2R7BhBYKlPQWkVqI
	22rzmtN6tVB8QrxymdEE7ohbJJdsaf6GyjhNDh1T80PgXrJHU7bAUNlKXhIG
X-Received: by 2002:a05:6402:501c:b0:672:bc73:a124 with SMTP id
 4fb4d7f45d1cf-679bb092fdbmr1761172a12.24.1777387159785; Tue, 28 Apr 2026
 07:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl> <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
 <20260427-rudel-gipsabdruck-a7884db4ecea@brauner> <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
 <20260428-zoodirektor-latten-e412db97141d@brauner>
In-Reply-To: <20260428-zoodirektor-latten-e412db97141d@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 28 Apr 2026 16:39:06 +0200
X-Gm-Features: AVHnY4Ja3pLpw7UMkXw0oBF-9fgYduWvYEChf9BQ65RTEdqUwZXM4GrqcMzSxBY
Message-ID: <CAGudoHHMG2Arne=B1XnJmSesfUH4se5eEQ2Lsc0FRmCxr3AECw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
To: Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8F34D488628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6218-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,arndb.de,zytor.com,suse.cz,infradead.org,linutronix.de,efficios.com,cyphar.com,linuxfoundation.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 10:55=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> On Mon, Apr 27, 2026 at 06:30:42PM +0200, Mateusz Guzik wrote:
> > On Mon, Apr 27, 2026 at 5:14=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > > Things proceed to handle_truncate:
> > > >       int error =3D get_write_access(inode);
> > > >       if (error)
> > > >               return error;
> > > >
> > > >       error =3D security_file_truncate(filp);
> > > >       if (!error) {
> > > >               error =3D do_truncate(idmap, path->dentry, 0,
> > > >                                   ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> > > >                                   filp);
> > > >       }
> > > >
> > > > I'm going to ignore the LSM situation and do_truncate failure modes=
 in this one.
> > > >
> > > > AFAICS nothing prevents the same user from racing against file crea=
tion to
> > > > execve it, which starts with exe_file_deny_write_access. Should the
> > > > other thread win the race, get_write_access will fail and the WARN_=
ON
> > > > splat will be generated. That is definitely a problem.
> > >
> > > That can't happen:
> > >
> > > static inline int get_write_access(struct inode *inode)
> > > {
> > >         return atomic_inc_unless_negative(&inode->i_writecount) ? 0 :=
 -ETXTBSY;
> > > }
> > >
> > > and the check is:
> > >
> > > error =3D handle_truncate(idmap, file);
> > > if (unlikely(error > 0)) {
> > >
> > > This was a catch all for broken LSM hook or ->open() instance.
> > >
> >
> > So with this prog:
> > #include <fcntl.h>
> >
> > int main(void)
> > {
> >     open("test", O_TRUNC);
> > }
> >
> > I verified writecount is 0 on entry to handle_truncate like so:
> >
> > bpftrace -e 'kprobe:security_file_truncate { @[comm, (int64)((struct
> > file *)arg0)->f_path.dentry->d_inode->i_writecount.counter] =3D count()=
;
> > }'
> >
> > @[a.out, 1]: 1
> >
> > i.e., get_write_access in handle_truncate transitioned the count 0 -> 1
> >
> > but then what prevents the following race:
> >
> > CPU0                    CPU1
> > open("test")            execve("test")
> >   handle_truncate         do_open_execat
> >                             exe_file_deny_write_access # should
> > succeed as count is 0?
> >   get_write_access # should fail as the count is now -1?
>
> I'm not arguing that get_write_access() cannot fail. I'm arguing that it
> cannot hit that WARN_ON() as you said above because get_write_access()
> returns either 0 or -ETXTBUSY.

ops, right:
  4681         =E2=94=82       error =3D handle_truncate(idmap, file);
  4682         if (unlikely(error > 0)) {
  4683                 WARN_ON(1);
  4684                 error =3D -EINVAL;
  4685         }

I mentally had it warn on any error.


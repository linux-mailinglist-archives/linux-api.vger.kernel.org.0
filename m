Return-Path: <linux-api+bounces-6209-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJJQGkqP72mhCwEAu9opvQ
	(envelope-from <linux-api+bounces-6209-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 18:31:06 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E150476670
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 18:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E958E3003633
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9553D6673;
	Mon, 27 Apr 2026 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLUXXzdF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762C3D349F
	for <linux-api@vger.kernel.org>; Mon, 27 Apr 2026 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307460; cv=pass; b=HyFK+A8f9Zri7rfDY7h0PBoXHizuYYADyqDEJvaKeGjvF86zh58kxCkjt3JSS0WkTBiKkHciBGRQeyhUgzxkuEvhGyJognuONK3L2zBheA2x7tK/sUHrqsZhjdPdllIeu8ya0wLmDisS8rkf4UkLohByUK8/sIATxU/kG3hSN1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307460; c=relaxed/simple;
	bh=idvner3mgft23dklNp8J4rH+ZI4P2VAwnJOBXPrMcrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9rJb6HmDjcD+RqkW8nXv/Y/BcUfXJLvIBBIXZt221yHRNQG7++cG5NK7FblAlWlvNF5sSnLJn2m7d3eCUOWk8BKigGoMbfYqPawju6JyqxrVx0Oob2WuhwUyfGpQByUCTWJwatf/ZpgvFJaysPD7ykVK8Bvx9oNajHikxT2Q+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLUXXzdF; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9358bc9c50so1386311566b.1
        for <linux-api@vger.kernel.org>; Mon, 27 Apr 2026 09:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777307455; cv=none;
        d=google.com; s=arc-20240605;
        b=Tf4zxvZ538diuQiuizYCv5WyXMGr+VL9ygzpexlCtsESWEPvJwTky9hY/1E4WvcQMb
         03ucj7eY5h8ntaQg2CvFVLotYQbSN1oe+haiy5MpCCpXqVofUkxU7Yo2qTsYAibjgcq8
         uL8fvIxtxTBZSNTMA2qEaIkgvuK7WpKixzAKiH8yUuh/TWBIxd99nqMEywrfjbUpqAiv
         QTCTDYY8Uh3G8GRSlAMLzHrpmRneBguv+YWVShktm0s/okuZArjjn0RBRT0IoBogLlhT
         vdXIzE3quGlmIgF8aNusuqk31xpKn1S+XqOV3L9D4MO1o4tvF7B3GeHR7C9WTFMtdW1U
         X86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        fh=gi9URzMVUVOINwyYtKML8q7MohR+5ekltOLWcYGun3I=;
        b=QFv038CaORWh6KA99q0ccS3nhfm+8zeEB8H3O9+kNuiTDP70NywvJMSpFq/MdRL7Un
         AtJ+FoBrCKRDwUgL9d30oQUzgojYrPiI5vdZBqm3yl68eAKu1HZx6ZCN8NAWrbuepnN/
         hsZ6Hfr3H1bF/1/cptGNtqGAaI2EJ3kYdI06xoWYEwzfqrS/Lo+zSeq/CpVukUG/YfjA
         ZFh7ntfbRrif+MuD6xnoqOfTBtoT/J0U8ehoDlXO6W2Q2JTaBhgO9babHBsfxronIEqG
         qOSiBNc38dyB1ByYDxGP2nNgbmRp3b/Tu0c+uK10jFlNXKxmlM/P530UrDOQPVY1klR6
         WVqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777307455; x=1777912255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        b=eLUXXzdF+kXYoyBc8nSDmCGGAz/1e0/zuWoSv5U3a1szoR5/g7LPlWio54onwM2f8y
         /8/tfR/sYCe8SLelIiai1EG5uW5dqol5GkS67zuvpg4pUSLy1GZpDgVKF2PlrzVmHTtK
         Y51i0ML2jdtNzC2eA/n8PcF/oH1X5FdbdqJEwlChduJbJXbDSDV0M3Ope5EchKkgPN41
         K785yoOePwIMaU9Y4v1u/mdZaL55zPAfLu0oQTHNO1nrB1OKKGUD+NamK0YWeAN22B42
         jgbE46KOamulWpQfg62tdVOuYSUVuJb/SiK0N3Oyo+s0MYwSchOdV6UihKPkMb5VUJ3q
         p8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777307455; x=1777912255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B7Z/bR7l35cxDwn9+LDbQum27vsLynWJhwJbt8jzAnU=;
        b=fonwjPrwRAEn/Cph9YxxpNvPF70TPyuezIxhSusizSCcb36IgT5j7VXALoI9Vdo2mk
         PDmwg0l4kMpmeJCr/uxwK2iXHuZqXblhAisK4tgx6TlqbbYJTz9vu+JMIh5op2fyVGEN
         lZpWN3ROrwtBX1yIJb/syqJJ8rnnISNJFJHPBPubjEpOjLNU3XBMtg6mAZ8mWNIHNIQo
         DYrP9KBC+CnxTz5JgdVuhcuv+3AY1clGUzIEb5RoFR4gGTfJzCHy19aWEoamZdVVrTO4
         V95GxdcrFvdLnUw+eAlsZNaPZQ4/UZMDiq2tHxGfKMLF+FZAVjKQi7fHYWloeojiMTfC
         aAnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Bzw4M0nbwWyzQ93xMuedp90xPVMlwgGyrra9KOedLWsgp12X15sAxFHYvts4Dy1XpaJJkFPwN06w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75fQcNJprLAwfBCRMab9i5qpvgqA3HqHxb9+TeaplY8O4a3/U
	KoIcb7ZWmqDyQzM+7Kaa6RiUF4oUSWH3uCLt6BdawEc6bbas36vo46THUv5e/a/lABNdfDKm577
	M5tHPnxhW/Sa8gNyG9WM3ZcjYHYjZvqk=
X-Gm-Gg: AeBDievzM/GfPErtHTly46Xf0CnKvetieLaCp5e0fuGW+TTkYGoroK8yb3u6PC1Otwu
	ham01P2eJursBhrGM5YoOyXnyW434ZFQzt5nAh+bPb0eEoVftiQwJCUHZOwQbtg4+TZYw600nnX
	uGNAgNmKD13Jsed3a1cZBZld7CA+tJGE1jeymry6nwKn8RZz8wk18+3pwiYb/cwsAW0LLO5RRL5
	3VViUwQDZuyOl9uRMUOR/v8RvQa1Yj4xgLGUfpaMQ8aMPmwuOHiz3QYWw1M2TUZAgF09oPVFztH
	hj6hS7VP/p4XSGgu53o/eLQo6ee/OwCSk0CPWvwFGe1+ckRnosZqLlRe6YKB
X-Received: by 2002:a17:906:8e15:b0:b9c:4fa:9141 with SMTP id
 a640c23a62f3a-ba419077377mr2070161466b.9.1777307454882; Mon, 27 Apr 2026
 09:30:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl> <20260412135434.3095416-2-jkoolstra@xs4all.nl>
 <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh> <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
In-Reply-To: <20260427-rudel-gipsabdruck-a7884db4ecea@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 27 Apr 2026 18:30:42 +0200
X-Gm-Features: AVHnY4ISYjfmOuhoMK9ONLGmIrCNFHHU0Ih5PKAcLvuNRoFbTb0DP2K6JgsHNoI
Message-ID: <CAGudoHFLSHhDZoC6maLsn234dMQVnG4ZbpKXoVrueGujArNF-A@mail.gmail.com>
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
X-Rspamd-Queue-Id: 0E150476670
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6209-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 5:14=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > Things proceed to handle_truncate:
> >       int error =3D get_write_access(inode);
> >       if (error)
> >               return error;
> >
> >       error =3D security_file_truncate(filp);
> >       if (!error) {
> >               error =3D do_truncate(idmap, path->dentry, 0,
> >                                   ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
> >                                   filp);
> >       }
> >
> > I'm going to ignore the LSM situation and do_truncate failure modes in =
this one.
> >
> > AFAICS nothing prevents the same user from racing against file creation=
 to
> > execve it, which starts with exe_file_deny_write_access. Should the
> > other thread win the race, get_write_access will fail and the WARN_ON
> > splat will be generated. That is definitely a problem.
>
> That can't happen:
>
> static inline int get_write_access(struct inode *inode)
> {
>         return atomic_inc_unless_negative(&inode->i_writecount) ? 0 : -ET=
XTBSY;
> }
>
> and the check is:
>
> error =3D handle_truncate(idmap, file);
> if (unlikely(error > 0)) {
>
> This was a catch all for broken LSM hook or ->open() instance.
>

So with this prog:
#include <fcntl.h>

int main(void)
{
    open("test", O_TRUNC);
}

I verified writecount is 0 on entry to handle_truncate like so:

bpftrace -e 'kprobe:security_file_truncate { @[comm, (int64)((struct
file *)arg0)->f_path.dentry->d_inode->i_writecount.counter] =3D count();
}'

@[a.out, 1]: 1

i.e., get_write_access in handle_truncate transitioned the count 0 -> 1

but then what prevents the following race:

CPU0                    CPU1
open("test")            execve("test")
  handle_truncate         do_open_execat
                            exe_file_deny_write_access # should
succeed as count is 0?
  get_write_access # should fail as the count is now -1?


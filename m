Return-Path: <linux-api+bounces-6659-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2BD6MkRmPGrtnggAu9opvQ
	(envelope-from <linux-api+bounces-6659-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:20:36 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB486C1E14
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 01:20:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HmdTJSXl;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6659-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6659-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C8C9302DCC9
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2026 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC063C583B;
	Wed, 24 Jun 2026 23:20:25 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7165192
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 23:20:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782343225; cv=none; b=p18cLYuFYsXZcnYSPRg8spL0qCdv0gycYm8Qs5RuORd406MNtzTore9IkwNSuwraxulQkd2wmHnfvzsupo7ZAnaArHwghAuuA2NWuZ3rSZf9+flh8dDH17tL7LRViC5Hq/4i+HfL1lBH30SjyMKPq5MNwvVX3MwC29Yx9Kg3hNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782343225; c=relaxed/simple;
	bh=FqtxWFhxAqLeJeDxZp6+yvzQAQhwoeAOz9hwgZZMrAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWAwHfKEG75X+N3L7XFdDIkFsPDKbenzwTJwJ7oc56gKwMxA51Q4ZAiaJJB+yczcZ0RYlTSiTHF43XFwo+xfCJHA7OicvXwIfDf4Yboa2k2e8ZOnlB8KPTZMX5Q6ehSMVJK0zo8bYJl7AB8J7RD2KPKRAs4Pvf5kSLF+iFBy84E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmdTJSXl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C211F01559
	for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782343223;
	bh=/jIiNebKNU+6IMyVmekk59ZlLx4QpdG77Io+qQZfEg0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HmdTJSXltdTMIk/6ZYdZZp4EOXLVWuyNvP+9ZZeETEfRJfcJ4SkQKs1YFP3ZkDlvR
	 S0ajjXSigiJBJ9xP8Av1J045fDWar/epYLeAa2Rsyz81mIuccuRh3hqTjcOmVa8pHa
	 tlEkeyp8bWglf04XSTxlXhXB+tVtjOukXKp/lhuKTClZjPcMLUuPn6d8XgVElXqzVy
	 olYWlCcJvmHpR8UGwuViXwK8+ZMSPRC5++BwLxj4n5Q4YOLoJCxim4b4eevsJ9pnG4
	 8l2KrfcAZOQnj4UZ2tQwZkL9Eg53t4P/PYRL40yKbSR+JUZbSqW/9rgNjp72GC6HNy
	 rCbhIjQVoZ4YQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-396bed274b9so16538621fa.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2026 16:20:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpF+ShdAv3ENh4Ulqbxa0/ZBuVQsYST/T5ShDRDyvyeLT9O4gBOiWnCQx75YT6TzGB795sPqDAzimc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDjv22lwl1AAigRoI5fOlQn+Y5b/qNwGZNlt1DY6x93UA1dlY
	GU2h4i3uQlcqZL0Y3e0WrrKYLvcHanInY+wl094N5ETbXbxfdnchMvUzRo2OkdLwJl3zBm12pjc
	LzwQa7hw2i/1PwCim00oZ74HyOAvUc3zhBaSRnvMg
X-Received: by 2002:a05:6512:70:b0:5aa:6f89:9378 with SMTP id
 2adb3069b0e04-5aea1f4cc51mr17819e87.33.1782343221845; Wed, 24 Jun 2026
 16:20:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com> <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
In-Reply-To: <CALCETrWhXNetw-BsAaoyT31suMmjYLdMh9MAuLB2Lvk2ac-31g@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 24 Jun 2026 16:20:09 -0700
X-Gmail-Original-Message-ID: <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
X-Gm-Features: AVVi8CcU53d_udrdy_WfBTRtqPGEK2pcv7rckHwMVUx8ncAdX2VQVQ70Ly2dMNA
Message-ID: <CALCETrU3bgUxp0k1y-U-uL0-fW2016Gmsyu9O_=830czEUGMcQ@mail.gmail.com>
Subject: Re: [RFC] Null Namespaces
To: Andy Lutomirski <luto@kernel.org>
Cc: John Ericson <mail@johnericson.me>, Li Chen <me@linux.beauty>, 
	Cong Wang <cwang@multikernel.io>, Christian Brauner <brauner@kernel.org>, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Sergei Zimmerman <sergei@zimmerman.foo>, Farid Zakaria <farid.m.zakaria@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6659-lists,linux-api=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luto@kernel.org,m:mail@johnericson.me,m:me@linux.beauty,m:cwang@multikernel.io,m:brauner@kernel.org,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:jack@suse.cz,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:viro@zeniv.linux.org.uk,m:kees@kernel.org,m:sergei@zimmerman.foo,m:farid.m.zakaria@gmail.com,m:faridmzakaria@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[johnericson.me,linux.beauty,multikernel.io,kernel.org,vger.kernel.org,arndb.de,redhat.com,alien8.de,linux.intel.com,zytor.com,suse.cz,lwn.net,linuxfoundation.org,zeniv.linux.org.uk,zimmerman.foo,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,johnericson.me:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BB486C1E14

On Wed, Jun 24, 2026 at 4:06=E2=80=AFPM Andy Lutomirski <luto@kernel.org> w=
rote:
>
> On Wed, Jun 24, 2026 at 3:52=E2=80=AFPM John Ericson <mail@johnericson.me=
> wrote:

> >   - null current working directory: relative paths with traditional,
> >     non-`*at` system calls (and `*at` ones using `AT_FDCWD`) don't work=
.
>
> It's perfectly valid to cd to a directory that does not belong to
> one's namespace.  We have fchdir.  What's wrong with letting it
> continue working?
>
> Regardless of that, the current directory either needs to be a
> directory or to be nothing at all, and if we support the latter, we
> need to figure out what /proc will show.

Thinking about this more: I think that handling CWD might actually be
a prerequisite for the series and has little to do with namespaces.
Maybe try adding, as a standalone feature, the ability to have a null
CWD.  Define semantics and see what the implementation looks like.

Then, if you add null namespaces, you could optionally make
transitioning to a null namespace set a null CWD.  Or those features
could be orthogonal.


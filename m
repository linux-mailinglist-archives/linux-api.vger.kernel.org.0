Return-Path: <linux-api+bounces-2738-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A69A9D1A92
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2024 22:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CA2AB210BA
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2024 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBDD1E47DA;
	Mon, 18 Nov 2024 21:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="PlqX2to/"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA11B0F3C
	for <linux-api@vger.kernel.org>; Mon, 18 Nov 2024 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965084; cv=none; b=YVw358w5E8xjorct5PnSBK0qPAaR8au70pR9TeLRJq/0/V9bHPrw4zdzzG/H3jYc4h4YepdWZ2BAtnPezycqfOuweCcJJQardJkI4eXrlypdiKQVc+GneoGA0Knmdqys7bDRaA+5OhRBMhCGl7jrdoofpgKkEQNw7ZPR4EKcKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965084; c=relaxed/simple;
	bh=O5a25Qtjne3Zv/V3w2gZEoZkgc2X9l6XRk87LsCYa/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lm7Q1lyrw9Ly76pt95yavIsxYIJanurq1iEsLSHM417DWd+A+0yHAXWgunzpAYf88ymBYexgJEY1w2iGZmKaMGtroPPAw/9ahxu5XRtpy3NaizHVF9b1GMe3cdGCRqTWRsyXwtDpMBDfyw4THDKdqUuvjw6fZ55ruUxBzrDyvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=PlqX2to/; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G66iKZoEMFWqwAOVsg26zAkA1V0L1hFf4xkQ1b8KXH8=; t=1731965081; x=1732829081; 
	b=PlqX2to/LmpcP/W97Nb4tT1k56mJcnF+sZC5BYgLtY3k+eQuUy1TTuJgdnV7M8pFJ3L8TDqDsPl
	huR6uSIXZRhd0+WhNbG9mCiJpvEmEWIVGpJnlwgCsP3y7/JGFayNSsqNabgvqJsxkVCTODaK7ViXQ
	2Jgv8greOxqUMjLL6xL7i/9PcrZQnWFe60sD9gA1pgjnyojM0XFbbJA6OzhZ8d8WLixcmE0qQeJ4X
	0md1HGegbQzBTSijA2J1y7mthK1BZWZfqMqVX3BjQaqQOuBkLvsq5H+K4mE1iMpQFnxQxMvx9obwV
	F8yPR2OPsaYpXWJflZ6KOHtXdgRomwY5ZBpw==;
Received: from mail-ot1-f44.google.com ([209.85.210.44]:47502)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tD9EY-00026p-Gr; Mon, 18 Nov 2024 13:24:35 -0800
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7180d9d0dcbso1334383a34.3;
        Mon, 18 Nov 2024 13:24:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEufbhj2gNGw+DdNemx3M4L5lXRrt2in4F/qbWQOmHOk9QOXr9RIPnMgLPxQitSIyEYpsXYItuOCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRup/ldynr6QB6C0VYzXVEZN4wrMwQNYQX0b5hD6COaSadTip
	B/vv1fzihhiuNUFvgnLgNLyZwn5cHEt+HfOyy+1pm7KgTlJSOfvHmuVyrX1Tb8U9SREgwzxxmuw
	UqnLfcybA3ObowP7TJwkNHW+x4XU=
X-Google-Smtp-Source: AGHT+IEx9eUcIdlRPEhBEDAM9A5zhDSrhkSzbONS0gxAHLCxeSaVTovr4IR9SMZvhsC5ZyFtLyllr3iRH6dOduPC4is=
X-Received: by 2002:a05:6830:a91:b0:718:d7c:2ef2 with SMTP id
 46e09a7af769-71a778fd183mr11365768a34.1.1731965073876; Mon, 18 Nov 2024
 13:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-13-ouster@cs.stanford.edu> <202411132114.VB5yFmtR-lkp@intel.com>
In-Reply-To: <202411132114.VB5yFmtR-lkp@intel.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 18 Nov 2024 13:23:57 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyeJ2HWxOZj8uY0_Cu47Yy_hAYfSRGmYpNfLGd2PR7Q-Q@mail.gmail.com>
Message-ID: <CAGXJAmyeJ2HWxOZj8uY0_Cu47Yy_hAYfSRGmYpNfLGd2PR7Q-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
To: kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 1a99e790efc5595ebc7b409aae77a077

I believe I have fixed all of the kernel test robot issues reported
under this subject line.

-John-


On Wed, Nov 13, 2024 at 5:53=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi John,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/ne=
t-homa-define-user-visible-API-for-Homa/20241112-074535
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20241111234006.5942-13-ouster%40=
cs.stanford.edu
> patch subject: [PATCH net-next v2 12/12] net: homa: create Makefile and K=
config
> config: riscv-randconfig-r112-20241113 (https://download.01.org/0day-ci/a=
rchive/20241113/202411132114.VB5yFmtR-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 5=
92c0fe55f6d9a811028b5f3507be91458ab2713)
> reproduce: (https://download.01.org/0day-ci/archive/20241113/202411132114=
.VB5yFmtR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411132114.VB5yFmtR-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> net/homa/homa_sock.c:201:31: sparse: sparse: cast removes address spac=
e '__rcu' of expression
>    net/homa/homa_sock.c:248:17: sparse: sparse: context imbalance in 'hom=
a_sock_shutdown' - different lock contexts for basic block
>    net/homa/homa_sock.c:303:21: sparse: sparse: context imbalance in 'hom=
a_sock_bind' - different lock contexts for basic block
>
> vim +/__rcu +201 net/homa/homa_sock.c
>
> 8ddf00265eb650 John Ousterhout 2024-11-11  183
> 8ddf00265eb650 John Ousterhout 2024-11-11  184  /*
> 8ddf00265eb650 John Ousterhout 2024-11-11  185   * homa_sock_unlink() - U=
nlinks a socket from its socktab and does
> 8ddf00265eb650 John Ousterhout 2024-11-11  186   * related cleanups. Once=
 this method returns, the socket will not be
> 8ddf00265eb650 John Ousterhout 2024-11-11  187   * discoverable through t=
he socktab.
> 8ddf00265eb650 John Ousterhout 2024-11-11  188   */
> 8ddf00265eb650 John Ousterhout 2024-11-11  189  void homa_sock_unlink(str=
uct homa_sock *hsk)
> 8ddf00265eb650 John Ousterhout 2024-11-11  190  {
> 8ddf00265eb650 John Ousterhout 2024-11-11  191          struct homa_sockt=
ab *socktab =3D hsk->homa->port_map;
> 8ddf00265eb650 John Ousterhout 2024-11-11  192          struct homa_sockt=
ab_scan *scan;
> 8ddf00265eb650 John Ousterhout 2024-11-11  193
> 8ddf00265eb650 John Ousterhout 2024-11-11  194          /* If any scans r=
efer to this socket, advance them to refer to
> 8ddf00265eb650 John Ousterhout 2024-11-11  195           * the next socke=
t instead.
> 8ddf00265eb650 John Ousterhout 2024-11-11  196           */
> 8ddf00265eb650 John Ousterhout 2024-11-11  197          spin_lock_bh(&soc=
ktab->write_lock);
> 8ddf00265eb650 John Ousterhout 2024-11-11  198          list_for_each_ent=
ry(scan, &socktab->active_scans, scan_links) {
> 8ddf00265eb650 John Ousterhout 2024-11-11  199                  if (!scan=
->next || scan->next->sock !=3D hsk)
> 8ddf00265eb650 John Ousterhout 2024-11-11  200                          c=
ontinue;
> 8ddf00265eb650 John Ousterhout 2024-11-11 @201                  scan->nex=
t =3D (struct homa_socktab_links *)hlist_next_rcu(&scan
> 8ddf00265eb650 John Ousterhout 2024-11-11  202                           =
       ->next->hash_links);
> 8ddf00265eb650 John Ousterhout 2024-11-11  203          }
> 8ddf00265eb650 John Ousterhout 2024-11-11  204          hlist_del_rcu(&hs=
k->socktab_links.hash_links);
> 8ddf00265eb650 John Ousterhout 2024-11-11  205          spin_unlock_bh(&s=
ocktab->write_lock);
> 8ddf00265eb650 John Ousterhout 2024-11-11  206  }
> 8ddf00265eb650 John Ousterhout 2024-11-11  207
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki


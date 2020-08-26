Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C4E25312B
	for <lists+linux-api@lfdr.de>; Wed, 26 Aug 2020 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHZOYZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 26 Aug 2020 10:24:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:8870 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgHZOXh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 26 Aug 2020 10:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598451814;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=vlFjPjGsBeWfnakdgDl9RQ72Zvd7He5Fjtfa+KRA5hI=;
        b=EErGYoj6ushAypOJkxoloiORme+T87usmGr2U44EUFKcXhji7dijtd5gTBU1H9bUB9
        MYJShEWlY6Unv83wmsWoQFxoFf9rGCvPddy7WaFnKJHidkdj3u7J8UCwLb5kIN+NTRbM
        4Awt5VpFKlp+MiHxOJlQdnp9uTIX4KnDg/xSpfQuUxLMi6N7r8jog2r3stoMFAhRXfzU
        fs5maugOEL1hEvucDzti+Y27a1Cd/k77LvLM1wXnDu+JA/SyB0A8v4O5znr37+96q3qg
        pgS5c5RkvcCtgztmSXYLx0lSXU5qVL6Pri7TcVNgbAMy+BYf3w29Pgw+I6OsFoZVaOJp
        I72Q==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaL/Scj1g="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw7QEMgjED
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 26 Aug 2020 16:22:42 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v33 01/12] Linux Random Number Generator
Date:   Wed, 26 Aug 2020 16:22:41 +0200
Message-ID: <2144138.CrzyxZ31qj@tauon.chronox.de>
In-Reply-To: <20200826142742.GA24519@xsang-OptiPlex-9020>
References: <20200826142742.GA24519@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Mittwoch, 26. August 2020, 16:27:42 CEST schrieb kernel test robot:

Hi,

> >> drivers/char/lrng/lrng_chacha20.c:54:47: sparse: sparse: cast to
> >> restricted __le32
>    drivers/char/lrng/lrng_chacha20.c:58:47: sparse: sparse: cast to
> restricted __le32 --

Thanks for the reports. Both, the __poll_t and the __le32 issues are fixed in 
v34.

Ciao
Stephan



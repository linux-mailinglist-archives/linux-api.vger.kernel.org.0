Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA1625180C
	for <lists+linux-api@lfdr.de>; Tue, 25 Aug 2020 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgHYLwP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 25 Aug 2020 07:52:15 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:33681 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYLwM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 25 Aug 2020 07:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598356325;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=D2qqsSA5sHWxkwGYpXIctTVmxWLQwISn1aS53FcUiHw=;
        b=sJXEBJaiRrHx8Ivj6PCqR+pcomDUO/Z+qeeRx5lKpv2HBVNgflv5cYeyhMUnNMiSi6
        jyk0abqOyC7GK0/TAmPLJuy8PcwQmNKAQWwAmNxxYhIwS2zJ+TWRYVBtFCmQPbYprzde
        dd2cWAB5WY2dVKmyq6Z68vQP31ZnRWLaH/v0i+2TMSorKevT+FqYaXmz/XrXtGKsOVJ2
        iGU9eq0R+wBsDAUhBU4iSFJAituTnDbeSqmjBnJf5cbVI/D+fRnn/iiiTwxYgYRydpx6
        IfFjokgZDjNtuQti1/vIMK31jEOVADZRWiBZIY3OWKGCsOM8NJ8aVjlQT9Ijm7AAo+Bk
        nWqQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDaIvSXRbo="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw7PBpJb3K
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 25 Aug 2020 13:51:19 +0200 (CEST)
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
Subject: Re: [PATCH v34 01/12] Linux Random Number Generator
Date:   Tue, 25 Aug 2020 13:51:19 +0200
Message-ID: <6658249.kC03pvyZki@tauon.chronox.de>
In-Reply-To: <202008251912.50LKcRvL%lkp@intel.com>
References: <5695397.lOV4Wx5bFT@positron.chronox.de> <202008251912.50LKcRvL%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 25. August 2020, 13:28:53 CEST schrieb kernel test robot:

Hi,

> All warnings (new ones prefixed by >>):
> >> drivers/char/lrng/lrng_drng.c:381:6: warning: no previous prototype for
> >> 'lrng_reset' [-Wmissing-prototypes]
>      381 | void lrng_reset(void)
> 
>          |      ^~~~~~~~~~

The prototype is covered in an ifdef in lrng_internal.h as it is only needed 
for a specific configuration. I have moved the prototype out of that 
configuration conditional now.

Thanks.

Ciao
Stephan



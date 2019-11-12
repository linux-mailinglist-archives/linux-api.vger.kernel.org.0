Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB89F8C97
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 11:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKLKQq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Nov 2019 05:16:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33128 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfKLKQq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Nov 2019 05:16:46 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUTE0-0007dM-KT; Tue, 12 Nov 2019 11:16:40 +0100
Date:   Tue, 12 Nov 2019 11:16:39 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v24 01/12] Linux Random Number Generator
In-Reply-To: <9370249.4lZBqg7Imc@positron.chronox.de>
Message-ID: <alpine.DEB.2.21.1911121116130.1833@nanos.tec.linutronix.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2369119.jSEA3qhmGI@positron.chronox.de> <alpine.DEB.2.21.1911120041060.1833@nanos.tec.linutronix.de> <9370249.4lZBqg7Imc@positron.chronox.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1459376004-1573553800=:1833"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1459376004-1573553800=:1833
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 12 Nov 2019, Stephan Müller wrote:
> Am Dienstag, 12. November 2019, 00:54:16 CET schrieb Thomas Gleixner:
> > Can you please get rid of those?
> 
> Absolutely. I have removed that boiler plate disclaimer from all files.

Appreciated.

> Though I hope it is acceptable to wait for further comments before a 
> resubmission.

Of course!
--8323329-1459376004-1573553800=:1833--

Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71EC301E08
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbhAXSFu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 13:05:50 -0500
Received: from cvs.openbsd.org ([199.185.137.3]:11265 "EHLO cvs.openbsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbhAXSFu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 24 Jan 2021 13:05:50 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jan 2021 13:05:50 EST
Received: from cvs.openbsd.org (localhost [127.0.0.1])
        by cvs.openbsd.org (OpenSMTPD) with ESMTP id e1ff6703;
        Sun, 24 Jan 2021 10:58:28 -0700 (MST)
From:   "Theo de Raadt" <deraadt@openbsd.org>
To:     Otto Moerbeek <otto@drijf.net>
cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Christian Groessler <chris@groessler.org>,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>,
        Coreutils <coreutils@gnu.org>,
        William Ahern <william@25thandclement.com>,
        Erik Auerswald <auerswal@unix-ag.uni-kl.de>,
        Eric Pruitt <eric.pruitt@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Fabrice BAUZAC <noon@mykolab.com>, tech@openbsd.org,
        freebsd-hackers@freebsd.org, linux-api@vger.kernel.org,
        juli@clockworksquid.com, ed@nuxi.nl, oshogbo@freebsd.org
Subject: Re: [PATCH v3 (resend)] tee: Add -q, --quiet, --silent option to not write to stdout
In-reply-to: <YA2ztHUATu1gOxoV@clue.drijf.net>
References: <1f8ce444-35e2-56a7-dbd1-34e885372b11@gmail.com> <20210124121845.38293-1-alx.manpages@gmail.com> <YA2ztHUATu1gOxoV@clue.drijf.net>
Comments: In-reply-to Otto Moerbeek <otto@drijf.net>
   message dated "Sun, 24 Jan 2021 18:51:48 +0100."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61963.1611511108.1@cvs.openbsd.org>
Date:   Sun, 24 Jan 2021 10:58:28 -0700
Message-ID: <80701.1611511108@cvs.openbsd.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Otto Moerbeek <otto@drijf.net> wrote:

> On Sun, Jan 24, 2021 at 01:18:46PM +0100, Alejandro Colomar wrote:
> 
> > This is useful for using tee to just write to a file,
> > at the end of a pipeline,
> > without having to redirect to /dev/null
> > 
> > Example:
> > 
> > echo 'foo' | sudo tee -q /etc/foo;
> > 
> > is equivalent to the old (and ugly)
> 
> You keep repeating "ugly" as the reason you are wanting this.
> 
> I consider adding special options to command to solve an imagined
> issue that can be solved with a general concept like redirection ugly.
> Please stop pushing your diff to this list. So far nobody showed any
> interest.

I also see ZERO reason for this change.

This change will encourage the creation of non-portable scripts, which
harms backwards compatibility and portability, while increasing the
cognitive cost of building software in a simple and useable command
ecosystem.



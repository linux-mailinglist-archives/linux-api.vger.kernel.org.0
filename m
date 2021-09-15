Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDC40CA0D
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 18:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhIOQ3s (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 12:29:48 -0400
Received: from todd.t-8ch.de ([159.69.126.157]:48505 "EHLO todd.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhIOQ3s (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Sep 2021 12:29:48 -0400
Date:   Wed, 15 Sep 2021 18:28:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=t-8ch.de; s=mail;
        t=1631723308; bh=dbAIiQiQdYvDGfliNcf8DfQWjajin51kvD7oakmxX5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEHY0vzqiTS8z12ahdrEV+NIy3YCtoKwBuoPk6FNy9X/WLW2MrgtugQlFF7NS0V8Q
         QrI2f6OFli2GTcui1cSK2qshRgAnaUAAGshAF0yUjPjkg2XI7n9axlvIfFP604U6uN
         Y54kEZzQY1KPNx8Mq+uwk1XIRFVfj9AjRDRQoGrg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <3750b26b-f12e-4d05-b369-84e4c0ca95ee@t-8ch.de>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <YUIZKagx0bjJ3PEm@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUIZKagx0bjJ3PEm@kroah.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021-09-15T18:02+0200, Greg KH wrote:
> On Wed, Sep 15, 2021 at 05:49:34PM +0200, Thomas Weißschuh wrote:
> > Hi,
> > 
> > I would like to propose a new syscall that exposes the functionality of
> > request_module() to userspace.
> > 
> > Propsed signature: request_module(char *module_name, char **args, int flags);
> > Where args and flags have to be NULL and 0 for the time being.
> > 
> > Rationale:
> > 
> > We are using nested, privileged containers which are loading kernel modules.
> > Currently we have to always pass around the contents of /lib/modules from the
> > root namespace which contains the modules.
> > (Also the containers need to have userspace components for moduleloading
> > installed)
> > 
> > The syscall would remove the need for this bookkeeping work.
> 
> So you want any container to have the ability to "bust through" the
> containers and load a module from the "root" of the system?

Only those with CAP_SYS_MODULE.
Having this capability would also allow them load the module normally when
mounted in or potentially downloaded from the internet.

> That feels dangerous, why not just allow a mount of /lib/modules into
> the containers that you want to be able to load a module?

This is what we are currently doing. But sometimes this gets forgotten at some
point in the chain of nested containers/namespaces and things break.

> Why are modules somehow "special" here, they are just a resource that
> has to be allowed (or not) to be accessed by a container like anything
> else on a filesystem.

They are special insofar as they always have to match the running kernel.
Which is managed by the root namespace.

The biggest problems would probably arise if the root namespace has non-standard
modules available which the container would normally not have access to.

I think this is a big potential problem and which would not be justified by the
quality of life improvement.

Sorry for the noise.

Thomas

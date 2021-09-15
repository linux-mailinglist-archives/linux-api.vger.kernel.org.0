Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1269940C9AE
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhIOQEL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 12:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234166AbhIOQEL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Sep 2021 12:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8657E61164;
        Wed, 15 Sep 2021 16:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631721772;
        bh=nXQtiMGXJl/dD6TL+0pz2oTfvK+RhAwsJyp3+nnyKUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YFbjuuDZdBHSNOsM3hmiyKaqZnCKMmTg7hfcRhdqXDKkIc40cbHEQUdQsozyV7uUE
         FhTTFDY4SV6CziAlzQgLgslQ9IfSo0aSCp9QJsuhj0Zcmn/VvMGyWxkkfwxNHhZzIN
         UMporgguShPQCkhbYarZJLXMJOsn8oWB2P2gnF5k=
Date:   Wed, 15 Sep 2021 18:02:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Message-ID: <YUIZKagx0bjJ3PEm@kroah.com>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 15, 2021 at 05:49:34PM +0200, Thomas Weißschuh wrote:
> Hi,
> 
> I would like to propose a new syscall that exposes the functionality of
> request_module() to userspace.
> 
> Propsed signature: request_module(char *module_name, char **args, int flags);
> Where args and flags have to be NULL and 0 for the time being.
> 
> Rationale:
> 
> We are using nested, privileged containers which are loading kernel modules.
> Currently we have to always pass around the contents of /lib/modules from the
> root namespace which contains the modules.
> (Also the containers need to have userspace components for moduleloading
> installed)
> 
> The syscall would remove the need for this bookkeeping work.

So you want any container to have the ability to "bust through" the
containers and load a module from the "root" of the system?

That feels dangerous, why not just allow a mount of /lib/modules into
the containers that you want to be able to load a module?

Why are modules somehow "special" here, they are just a resource that
has to be allowed (or not) to be accessed by a container like anything
else on a filesystem.

thanks,

greg k-h

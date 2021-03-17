Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714F633F982
	for <lists+linux-api@lfdr.de>; Wed, 17 Mar 2021 20:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhCQTnb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Mar 2021 15:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232738AbhCQTnU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 17 Mar 2021 15:43:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C6E164F21;
        Wed, 17 Mar 2021 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616010200;
        bh=PUbMJ0M7lfsvvZpskEAU+Yfv+YAny8f2HXBYZHhkL04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPo0Ctit5bYMF2SfWVJkP54Qd0Ks5wLYhGYhKPiqerDmFh7mJ+34fWMAKog7rLRKp
         WOD0CFM5NuwAH0dZoHCUS5yYDTTEudmLA8nlRJ8MDoQnnYd3xZwOiyPM/mb6lJknX3
         wFFobIz7LZrYTHXNFknBUzvkGsNiB48+1eANtjUM=
Date:   Wed, 17 Mar 2021 20:43:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Min Li <min.li.xe@renesas.com>
Cc:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH net-next v1] misc: Add Renesas Synchronization Management
 Unit (SMU) support
Message-ID: <YFJb0ztWDCQsB3yN@kroah.com>
References: <1616007596-2402-1-git-send-email-min.li.xe@renesas.com>
 <YFJWWrX+UgXyD9NS@kroah.com>
 <OSBPR01MB4773D4FAD63E114761654006BA6A9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4773D4FAD63E114761654006BA6A9@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, Mar 17, 2021 at 07:34:44PM +0000, Min Li wrote:
> Hi Greg
> 
> You are right, this is not for the network tree.
> 
> Can you point me to the right tree to base this change for?

MAINTAINERS and scripts/get_maintainers.pl is your friend, please look
there.

thanks,

greg k-h

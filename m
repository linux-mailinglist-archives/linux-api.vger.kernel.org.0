Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36ADA15A636
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 11:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgBLKW5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 05:22:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:46280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgBLKW5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 12 Feb 2020 05:22:57 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 02:22:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="226820686"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 12 Feb 2020 02:22:53 -0800
Date:   Wed, 12 Feb 2020 18:02:11 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>, mdf@kernel.org,
        mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200212100211.GA10436@hao-dev>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
 <20200210163400.GA21900@willie-the-truck>
 <20200212031929.GB5645@hao-dev>
 <20200212053035.GA382718@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212053035.GA382718@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 11, 2020 at 09:30:35PM -0800, Greg KH wrote:
> On Wed, Feb 12, 2020 at 11:19:29AM +0800, Wu Hao wrote:
> > On Mon, Feb 10, 2020 at 04:34:01PM +0000, Will Deacon wrote:
> > > Hi,
> > > 
> > > On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> > > > This patch adds support for performance reporting private feature
> > > > for FPGA Management Engine (FME). Now it supports several different
> > > > performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> > > > and 'vtd_sip'. It allows user to use standard linux tools to access
> > > > these performance counters.
> > > 
> > > I had a quick look at this, and it mostly looks alright to me. Just a few
> > > high-level comments/questions:
> > 
> > Hi Will
> > 
> > Thanks a lot for the review! :)
> > 
> > > 
> > >   - I would still prefer for the PMU drivers to live under drivers/perf/
> > 
> > Hm.. one possible way is to create a platform device, and introduce a new
> > platform device driver under drivers/perf/.
> 
> No, do not abuse platform drivers, you have a real device, use it.

Sure, thanks for the comments. Then I don't have any other idea to move code to
drivers/perf/ directory, so probably only can live with current code.

Thanks
Hao

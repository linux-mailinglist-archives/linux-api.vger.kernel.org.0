Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDED727FF7E
	for <lists+linux-api@lfdr.de>; Thu,  1 Oct 2020 14:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbgJAMx1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Oct 2020 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJAMx1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 1 Oct 2020 08:53:27 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14327C0613D0;
        Thu,  1 Oct 2020 05:53:27 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C52CA26F; Thu,  1 Oct 2020 14:53:23 +0200 (CEST)
Date:   Thu, 1 Oct 2020 14:53:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v12 0/6] IOMMU user API enhancement
Message-ID: <20201001125322.GD30426@8bytes.org>
References: <1601051567-54787-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200928114053.79170d23@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928114053.79170d23@jacob-builder>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jacob,

On Mon, Sep 28, 2020 at 11:40:53AM -0700, Jacob Pan wrote:
> Just wondering if you will be able to take this for v5.10? There hasn't
> been any material changes since we last discussed in LPC. We have VFIO and
> other vSVA patches depending on it.

Queued for v5.10 now, thanks.

Regards,

	Joerg


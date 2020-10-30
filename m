Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF6E2A02AC
	for <lists+linux-api@lfdr.de>; Fri, 30 Oct 2020 11:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgJ3KSu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Oct 2020 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgJ3KSt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Oct 2020 06:18:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE5AC0613D7
        for <linux-api@vger.kernel.org>; Fri, 30 Oct 2020 03:18:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c9so790755wml.5
        for <linux-api@vger.kernel.org>; Fri, 30 Oct 2020 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9QnPAe/9TEZoI6Lq3d/QkgDd9m9jvfSBzhcmPvWbSw4=;
        b=xNIZ8cVBFbQ6bdjtq0Hmby0tUGqrogQ55WzB1NVugGBAxs6/uT7n7bTbHZG26skP/6
         vlBkhqQR3eH1Jh1mHIOKSojs8X8EfyS4S5Ck3WuvfBx1L89a7KWXB1WgMOpYcxRRC805
         I8j5s11o2aY3ulzx31MvrsaxIp5/9ov5SiZtTelhDB/pbex1AhTA5GLWYI5Z0McJChPO
         6MSvuxHNMhRWEGuowKnaPUgqPITviOE1D8Qtsg/3XDpv4nDGSkZ1i1Rw2Eg5Ycwrc1IC
         nZKvLRX+YDV7cPfrsoulWOqh6TJHwmx7YwkkL5kkvarpIlary1jzpnkRuyFGG4A0wPnn
         7PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9QnPAe/9TEZoI6Lq3d/QkgDd9m9jvfSBzhcmPvWbSw4=;
        b=mUkq3568d56LbyPG0TncvWcmcxcJZbPSztlcuYt8CkqCYq+aC35M+oZsn8B8OdCjZG
         yv3o24jOJr1jvbCgf0bhtGVI3CCxf5VmP8oFLpydlbK4yBU2mvtq51CWGlPkYI0jQ2QZ
         2YMjhzKej3S5qo2BUxC8+KXtK54uyADrsLFxd+GlLAcn6iMztolhXecWWj87uCULJzeM
         heAi0z1pvZBahBW+6j5+Gu1aTr66btkOKeqiErk6Ns8knt+XP2V3oABC91M+KI66Hpe2
         ite3E/4oIoAxsv+L6dzW1t2+tAXeJoRH1DOydenOXD4Gaac7A1txpyN5hKSLD5IzQxRG
         suAg==
X-Gm-Message-State: AOAM532n8uFNq/SAIil5fluyeulZ/WkIwPRRUtcJZaqItW/TXKsOSFfN
        VVRgSd9IQo1V22eclTWqbuw1dA==
X-Google-Smtp-Source: ABdhPJzmWJXNv2J4SwRd2WDFh46KarNhPjy8eGcF6DQVOctpW3uaD4eXLFO5VUk+d7zrIy//n4cEUA==
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr1755124wmd.60.1604053128250;
        Fri, 30 Oct 2020 03:18:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id r28sm10482662wrr.81.2020.10.30.03.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 03:18:47 -0700 (PDT)
Date:   Fri, 30 Oct 2020 11:18:27 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-api@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        Yi Sun <yi.y.sun@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/14] docs: Document IO Address Space ID (IOASID) APIs
Message-ID: <20201030101827.GB122147@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20201020135809.GA1515830@myrica>
 <20201026140506.1349dbb5@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201026140506.1349dbb5@jacob-builder>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 26, 2020 at 02:05:06PM -0700, Jacob Pan wrote:
> > This looks good to me, with small comments below.
> > 
> Can I add your Reviewed-by tag after addressing the comments?

Yes sure, this took forever to review so I'm happy not to do another pass :)


> > > +Each IOASID set is created with a token, which can be one of the
> > > +following token types:
> > > +
> > > + - IOASID_SET_TYPE_NULL (Arbitrary u64 value)  
> > 
> > Maybe NULL isn't the best name then. NONE?
> > 
> Agreed, 'NONE' makes more sense.

Although patch 5 only allows a NULL token for this type. So the name seems
fine, you could just fix this description.


> > > +IOASID core has the notion of "custom allocator" such that guest can
> > > +register virtual command allocator that precedes the default one.  
> > 
> > "Supersedes", rather than "precedes"?
> > 
> My understanding is that 'supersede' means replace something but 'precede'
> means get in front of something. I do want to emphasis that the custom
> allocator takes precedence over the default allocator.

Right it's ambiguous. The custom allocator does entirely replace the
allocation action, but the default one is still used for storage. Anyway,
you can leave this.


> > > +Let's examine the IOASID life cycle again when free happens *before*
> > > +unbind. This could be a result of misbehaving guests or crash. Assuming
> > > +VFIO cannot enforce unbind->free order. Notice that the setup part up
> > > +until step #12 is identical to the normal case, the flow below starts
> > > +with step 13.
> > > +
> > > +::
> > > +
> > > +     VFIO        IOMMU        KVM        VDCM        IOASID       Ref
> > > +   ..................................................................
> > > +   13 -------- GUEST STARTS DMA --------------------------
> > > +   14 -------- *GUEST MISBEHAVES!!!* ----------------
> > > +   15 ioasid_free()
> > > +   16                                             ioasid_notify(FREE)
> > > +   17                                             mark_free_pending
> > > (1)  
> > 
> > Could we use superscript ¹²³⁴ for footnotes? These look like function
> > parameters
> > 
> yes, much better
> 
> > > +   18                          kvm_nb_handler(FREE)
> > > +   19                          vmcs_update_atomic()
> > > +   20                          ioasid_put_locked()   ->           3
> > > +   21                                   vdcm_nb_handler(FREE)
> > > +   22            iomm_nb_handler(FREE)  
> > 
> > iommu_nb_handler
> > 
> got it
> 
> > > +   23 ioasid_free() returns(2)          schedule_work()           2  
> > 
> > I completely lost track here, couldn't figure out in which direction to
> > read the diagram. What work is scheduled?
> The time line goes downward but we only control the notification order in
> terms of when the events are received. Some completions are async thus out
> of order done by work items. The only in-order completion is the KVM update
> of its PASID translation table.
> 
> After #23, the async works are scheduled to complete clean up work outside
> the spinlock(held by the caller of the atomic notifier).
> 
> Any suggestions to improve the readability of the time line?

Maybe explain what happens from line 23: ioasid_free() schedules... a FREE
notification? Which happens on line 24 (corresponding to the second
schedule_work()?) and is handled by (a) VDCM to clear the device context
and (b) IOMMU to clear the PASID context, both ending up dropping their
ref.

> 
> > Why does the IOMMU driver drop
> > its reference to the IOASID before unbdind_gpasid()?
> > 
> This is the exception case where userspace issues IOASID free before
> unbind_gpasid(). The equivalent of unbind is performed in the IOASID_FREE
> notification handler. In IOASID_FREE handler, reference is dropped and
> private data deleted. After that, if unbind comes to IOMMU driver, it will
> not find IOASID private data therefore just return.

Right ok. As you noted below the damage is caused by and limited to the
guest, so I think it's fine.

> 
> > > +   24            schedule_work()        vdev_clear_wk(hpasid)
> > > +   25            teardown_pasid_wk()
> > > +   26                                   ioasid_put() ->           1
> > > +   27            ioasid_put()                                     0
> > > +   28                                                 Reclaimed
> > > +   29 unbind_gpasid()
> > > +   30            iommu_unbind()->ioasid_find() Fails(3)
> > > +   -------------- New Life Cycle Begin ----------------------------
> > > +
> > > +Note:
> > > +
> > > +1. By marking IOASID FREE_PENDING at step #17, no new references can be
> > > +   held. ioasid_get/find() will return -ENOENT;  
> > 
> > s/held/taken
> > 
> Got it.
> 
> > Thanks,
> > Jean
> > 
> > > +2. After step #23, all events can go out of order. Shall not affect
> > > +   the outcome.
> > > +3. IOMMU driver fails to find private data for unbinding. If unbind is
> > > +   called after the same IOASID is allocated for the same guest again,
> > > +   this is a programming error. The damage is limited to the guest
> > > +   itself since unbind performs permission checking based on the
> > > +   IOASID set associated with the guest process.

"guest process" can be confusing (process run by the guest?), just "guest"
might be better.

Thanks,
Jean

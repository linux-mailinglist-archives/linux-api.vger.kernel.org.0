Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB29D2A373D
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 00:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgKBXj0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 2 Nov 2020 18:39:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:28793 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgKBXj0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Nov 2020 18:39:26 -0500
IronPort-SDR: VleSwzEdQUP6Czkv4V8Q6y5moXg7lrD3gH5mvfeGa5N5gNJg8UoQmxdvKFTfYsQagKmHwNbSHR
 f4vtNNw1fblQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148825748"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="148825748"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 15:39:25 -0800
IronPort-SDR: V6dSkkgktjKnDH00TCGYsOm+CRknORWWDzuIhJKnyld/or8rgSHThWBHGoGL3B6IZohXN25J+4
 d8zpFfGvYOhA==
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="336324618"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 15:39:25 -0800
Date:   Mon, 2 Nov 2020 15:41:52 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
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
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v3 01/14] docs: Document IO Address Space ID (IOASID)
 APIs
Message-ID: <20201102154152.0e95ab98@jacob-builder>
In-Reply-To: <20201030101827.GB122147@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1601329121-36979-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20201020135809.GA1515830@myrica>
        <20201026140506.1349dbb5@jacob-builder>
        <20201030101827.GB122147@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jean-Philippe,

On Fri, 30 Oct 2020 11:18:27 +0100, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Mon, Oct 26, 2020 at 02:05:06PM -0700, Jacob Pan wrote:
> > > This looks good to me, with small comments below.
> > >   
> > Can I add your Reviewed-by tag after addressing the comments?  
> 
> Yes sure, this took forever to review so I'm happy not to do another
> pass :)
> 
I am afraid I have to ask for another round of reviews since it was
suggested to keep IOASID allocation interface independent, instead of being
part of VFIO UAPI. Yi and I are working out the details to come up with a
PoC. As you might be aware, the need for this independent interface is that
we may have multiple users of PASID, e.g VDPA, user space drivers, etc.
The IOASID user interface also has slight impact on the IOASID core code,
which is why I am slow in response to your code review. Will incorporate
your review in the next round with support of independent user API.
Much appreciated!

> 
> > > > +Each IOASID set is created with a token, which can be one of the
> > > > +following token types:
> > > > +
> > > > + - IOASID_SET_TYPE_NULL (Arbitrary u64 value)    
> > > 
> > > Maybe NULL isn't the best name then. NONE?
> > >   
> > Agreed, 'NONE' makes more sense.  
> 
> Although patch 5 only allows a NULL token for this type. So the name seems
> fine, you could just fix this description.
> 
OK.

> 
> > > > +IOASID core has the notion of "custom allocator" such that guest
> > > > can +register virtual command allocator that precedes the default
> > > > one.    
> > > 
> > > "Supersedes", rather than "precedes"?
> > >   
> > My understanding is that 'supersede' means replace something but
> > 'precede' means get in front of something. I do want to emphasis that
> > the custom allocator takes precedence over the default allocator.  
> 
> Right it's ambiguous. The custom allocator does entirely replace the
> allocation action, but the default one is still used for storage. Anyway,
> you can leave this.
> 
OK

> 
> > > > +Let's examine the IOASID life cycle again when free happens
> > > > *before* +unbind. This could be a result of misbehaving guests or
> > > > crash. Assuming +VFIO cannot enforce unbind->free order. Notice
> > > > that the setup part up +until step #12 is identical to the normal
> > > > case, the flow below starts +with step 13.
> > > > +
> > > > +::
> > > > +
> > > > +     VFIO        IOMMU        KVM        VDCM        IOASID
> > > > Ref
> > > > +   ..................................................................
> > > > +   13 -------- GUEST STARTS DMA --------------------------
> > > > +   14 -------- *GUEST MISBEHAVES!!!* ----------------
> > > > +   15 ioasid_free()
> > > > +   16
> > > > ioasid_notify(FREE)
> > > > +   17                                             mark_free_pending
> > > > (1)    
> > > 
> > > Could we use superscript ¹²³⁴ for footnotes? These look like function
> > > parameters
> > >   
> > yes, much better
> >   
> > > > +   18                          kvm_nb_handler(FREE)
> > > > +   19                          vmcs_update_atomic()
> > > > +   20                          ioasid_put_locked()   ->           3
> > > > +   21                                   vdcm_nb_handler(FREE)
> > > > +   22            iomm_nb_handler(FREE)    
> > > 
> > > iommu_nb_handler
> > >   
> > got it
> >   
> > > > +   23 ioasid_free() returns(2)          schedule_work()
> > > > 2    
> > > 
> > > I completely lost track here, couldn't figure out in which direction
> > > to read the diagram. What work is scheduled?  
> > The time line goes downward but we only control the notification order
> > in terms of when the events are received. Some completions are async
> > thus out of order done by work items. The only in-order completion is
> > the KVM update of its PASID translation table.
> > 
> > After #23, the async works are scheduled to complete clean up work
> > outside the spinlock(held by the caller of the atomic notifier).
> > 
> > Any suggestions to improve the readability of the time line?  
> 
> Maybe explain what happens from line 23: ioasid_free() schedules... a FREE
> notification? Which happens on line 24 (corresponding to the second
> schedule_work()?) and is handled by (a) VDCM to clear the device context
> and (b) IOMMU to clear the PASID context, both ending up dropping their
> ref.
> 
Got it, I will add that.

> >   
> > > Why does the IOMMU driver drop
> > > its reference to the IOASID before unbdind_gpasid()?
> > >   
> > This is the exception case where userspace issues IOASID free before
> > unbind_gpasid(). The equivalent of unbind is performed in the
> > IOASID_FREE notification handler. In IOASID_FREE handler, reference is
> > dropped and private data deleted. After that, if unbind comes to IOMMU
> > driver, it will not find IOASID private data therefore just return.  
> 
> Right ok. As you noted below the damage is caused by and limited to the
> guest, so I think it's fine.
> 
OK.

> >   
> > > > +   24            schedule_work()        vdev_clear_wk(hpasid)
> > > > +   25            teardown_pasid_wk()
> > > > +   26                                   ioasid_put() ->           1
> > > > +   27            ioasid_put()                                     0
> > > > +   28                                                 Reclaimed
> > > > +   29 unbind_gpasid()
> > > > +   30            iommu_unbind()->ioasid_find() Fails(3)
> > > > +   -------------- New Life Cycle Begin ----------------------------
> > > > +
> > > > +Note:
> > > > +
> > > > +1. By marking IOASID FREE_PENDING at step #17, no new references
> > > > can be
> > > > +   held. ioasid_get/find() will return -ENOENT;    
> > > 
> > > s/held/taken
> > >   
> > Got it.
> >   
> > > Thanks,
> > > Jean
> > >   
> > > > +2. After step #23, all events can go out of order. Shall not affect
> > > > +   the outcome.
> > > > +3. IOMMU driver fails to find private data for unbinding. If
> > > > unbind is
> > > > +   called after the same IOASID is allocated for the same guest
> > > > again,
> > > > +   this is a programming error. The damage is limited to the guest
> > > > +   itself since unbind performs permission checking based on the
> > > > +   IOASID set associated with the guest process.  
> 
> "guest process" can be confusing (process run by the guest?), just "guest"
> might be better.
> 
> Thanks,
> Jean


Thanks,

Jacob

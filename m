Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02459299879
	for <lists+linux-api@lfdr.de>; Mon, 26 Oct 2020 22:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729430AbgJZVCq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 26 Oct 2020 17:02:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:18534 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729408AbgJZVCq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 26 Oct 2020 17:02:46 -0400
IronPort-SDR: HMqKp3TjzD6sSgiJaG3ZqyAbqq8gV8UnCaUie/Q0VmwbFlyRz/scBcFb5QfER5uYhb5RdGmCgx
 QO6foiDjGJjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232175267"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="232175267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 14:02:43 -0700
IronPort-SDR: Rpwgz74q8iMYBMaa4Xw4dslHQZsh8zc/YSfyibLs49v0eL5uA/NgXrhurmpCkEfgaIxCELC+TU
 +x5Glim8r4dg==
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="322680136"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 14:02:43 -0700
Date:   Mon, 26 Oct 2020 14:05:06 -0700
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
Message-ID: <20201026140506.1349dbb5@jacob-builder>
In-Reply-To: <20201020135809.GA1515830@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1601329121-36979-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20201020135809.GA1515830@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Jean-Philippe,

Thanks a lot for the review. Comments inline.

On Tue, 20 Oct 2020 15:58:09 +0200, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Mon, Sep 28, 2020 at 02:38:28PM -0700, Jacob Pan wrote:
> > IOASID is used to identify address spaces that can be targeted by device
> > DMA. It is a system-wide resource that is essential to its many users.
> > This document is an attempt to help developers from all vendors navigate
> > the APIs. At this time, ARM SMMU and Intel’s Scalable IO Virtualization
> > (SIOV) enabled platforms are the primary users of IOASID. Examples of
> > how SIOV components interact with IOASID APIs are provided in that many
> > APIs are driven by the requirements from SIOV.
> > 
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: linux-doc@vger.kernel.org
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> This looks good to me, with small comments below.
> 
Can I add your Reviewed-by tag after addressing the comments?

> > ---
> >  Documentation/driver-api/ioasid.rst | 648
> > ++++++++++++++++++++++++++++++++++++ 1 file changed, 648 insertions(+)
> >  create mode 100644 Documentation/driver-api/ioasid.rst
> > 
> > diff --git a/Documentation/driver-api/ioasid.rst
> > b/Documentation/driver-api/ioasid.rst new file mode 100644
> > index 000000000000..7f8e702997ab
> > --- /dev/null
> > +++ b/Documentation/driver-api/ioasid.rst
> > @@ -0,0 +1,648 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. ioasid:
> > +
> > +===================
> > +IO Address Space ID
> > +===================
> > +
> > +IOASID is a generic name for PCIe Process Address ID (PASID) or ARM
> > +SMMU SubstreamID. An IOASID identifies an address space that DMA
> > +requests can target.
> > +
> > +The primary use cases for IOASID are Shared Virtual Address (SVA) and
> > +multiple IOVA spaces per device. However, the requirements for IOASID
> > +management can vary among hardware architectures.
> > +
> > +For baremetal IOVA, IOASID #0 is used for DMA request without  
> 
>        bare metal
got it

> 
> > +PASID. Even though some architectures such as VT-d also offers
> > +the flexibility of using any PASIDs for DMA request without PASID.
> > +PASID #0 is reserved and not allocated from any ioasid_set.
> > +
> > +Multiple IOVA spaces per device are mapped to auxiliary domains which
> > +can be used for mediated device assignment with and without a virtual
> > +IOMMU (vIOMMU). An IOASID is allocated for each auxiliary domain as
> > default +PASID. Without vIOMMU, default IOASID is used for DMA map/unmap
> > +APIs. With vIOMMU, default IOASID is used for guest IOVA where DMA
> > +request with PASID is required for the device. The reason is that
> > +there is only one PASID #0 per device, e.g. VT-d, RID_PASID is per
> > PCI  
> 
>                                                on VT-d
got that
> 
> > +device.
> > +
> > +This document covers the generic features supported by IOASID
> > +APIs. Vendor-specific use cases are also illustrated with Intel's VT-d
> > +based platforms as the first example.
> > +
> > +.. contents:: :local:
> > +
> > +Glossary
> > +========
> > +PASID - Process Address Space ID
> > +
> > +IOASID - IO Address Space ID (generic term for PCIe PASID and
> > +SubstreamID in SMMU)
> > +
> > +SVA/SVM - Shared Virtual Addressing/Memory
> > +
> > +ENQCMD - Intel X86 ISA for efficient workqueue submission [1]
> > +!!!TODO: Link to Spec at the bottom  
> 
> Yes, or maybe hyperlinks at the end of this section would be better. There
> are references and lists all over the document so keeping things as close
> as possible avoids confusion.
> 
sounds good.

> > +
> > +DSA - Intel Data Streaming Accelerator [2]
> > +
> > +VDCM - Virtual Device Composition Module [3]
> > +
> > +SIOV - Intel Scalable IO Virtualization
> > +
> > +
> > +Key Concepts
> > +============
> > +
> > +IOASID Set
> > +-----------
> > +An IOASID set is a group of IOASIDs allocated from the system-wide
> > +IOASID pool. Refer to IOASID set APIs for more details.  
> 
>                          IOASID Set Level APIs
> 
Yes, I should use the exact section title.

> > +
> > +IOASID set is particularly useful for guest SVA where each guest could
> > +have its own IOASID set for security and efficiency reasons.
> > +
> > +IOASID Set Private ID (SPID)
> > +----------------------------
> > +Each IOASID set has a private namespace of SPIDs. An SPID maps to a
> > +single system-wide IOASID. Conversely, each IOASID may be associated
> > +with an alias ID, local to the IOASID set, named SPID.
> > +SPIDs can be used as guest IOASIDs where each guest could do
> > +IOASID allocation from its own pool and map them to host physical
> > +IOASIDs. SPIDs are particularly useful for supporting live migration
> > +where decoupling guest and host physical resources are necessary.
> > +
> > +For example, two VMs can both allocate guest PASID/SPID #101 but map to
> > +different host PASIDs #201 and #202 respectively as shown in the
> > +diagram below.
> > +::
> > +
> > + .------------------.    .------------------.
> > + |   VM 1           |    |   VM 2           |
> > + |                  |    |                  |
> > + |------------------|    |------------------|
> > + | GPASID/SPID 101  |    | GPASID/SPID 101  |
> > + '------------------'    -------------------'     Guest
> > + __________|______________________|____________________
> > +           |                      |               Host
> > +           v                      v
> > + .------------------.    .------------------.
> > + | Host IOASID 201  |    | Host IOASID 202  |
> > + '------------------'    '------------------'
> > + |   IOASID set 1   |    |   IOASID set 2   |
> > + '------------------'    '------------------'
> > +
> > +Guest PASID is treated as IOASID set private ID (SPID) within an
> > +IOASID set, mappings between guest and host IOASIDs are stored in the
> > +set for inquiry.
> > +
> > +IOASID APIs
> > +===========
> > +To get the IOASID APIs, users must #include <linux/ioasid.h>. These
> > APIs +serve the following functionalities:
> > +
> > +  - IOASID allocation/Free  
> 
>                          freeing (or release)
> 
got it

> > +  - Group management in the form of ioasid_set
> > +  - Private data storage and lookup
> > +  - Reference counting
> > +  - Event notification in case of a state change
> > +
> > +IOASID Set Level APIs
> > +--------------------------
> > +For use cases such as guest SVA it is necessary to manage IOASIDs at
> > +ioasid_set level. For example, VMs may allocate multiple IOASIDs for
> > +guest process address sharing (vSVA). It is imperative to enforce
> > +VM-IOASID ownership such that a malicious guest cannot target DMA
> > +traffic outside its own IOASIDs, or free an active IOASID that belongs
> > +to another VM.
> > +
> > +The IOASID set APIs serve the following purposes:
> > +
> > + - Ownership/permission enforcement
> > + - Take collective actions, e.g. free an entire set
> > + - Event notifications within a set
> > + - Look up a set based on token
> > + - Quota enforcement
> > +
> > +Each IOASID set is created with a token, which can be one of the
> > +following token types:
> > +
> > + - IOASID_SET_TYPE_NULL (Arbitrary u64 value)  
> 
> Maybe NULL isn't the best name then. NONE?
> 
Agreed, 'NONE' makes more sense.

> > + - IOASID_SET_TYPE_MM (Set token is a mm_struct)
> > +
> > +The explicit MM token type is useful when multiple users of an IOASID
> > +set under the same process need to communicate about their shared
> > IOASIDs. +E.g. An IOASID set created by VFIO for one guest can be
> > associated +with the KVM instance for the same guest since they share a
> > common mm_struct. +A token must be unique within its type.
> > +
> > +::
> > +
> > + struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota, u32
> > type) +
> > + int ioasid_adjust_set(struct ioasid_set *set, int quota);
> > +
> > + void ioasid_set_get(struct ioasid_set *set)
> > +
> > + void ioasid_set_put(struct ioasid_set *set)
> > +
> > + void ioasid_set_get_locked(struct ioasid_set *set)
> > +
> > + void ioasid_set_put_locked(struct ioasid_set *set)
> > +
> > + int ioasid_set_for_each_ioasid(struct ioasid_set *set,
> > +                                void (*fn)(ioasid_t id, void *data),
> > +				void *data)  
> 
> misaligned
> 
got it

> > +
> > +
> > +Individual IOASID APIs
> > +----------------------
> > +Once an ioasid_set is created, IOASIDs can be allocated from the set.
> > +Within the IOASID set namespace, set private ID (SPID) is supported. In
> > +the VM use case, SPID can be used for storing guest PASID.
> > +
> > +::
> > +
> > + ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t
> > max,
> > +                       void *private);
> > +
> > + int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
> > +
> > + void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
> > +
> > + int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
> > +
> > + void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
> > +
> > + void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> > +                   bool (*getter)(void *));
> > +
> > + ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
> > +
> > + int ioasid_attach_data(struct ioasid_set *set, ioasid_t ioasid,
> > +                        void *data);
> > + int ioasid_attach_spid(struct ioasid_set *set, ioasid_t ioasid,
> > +                        ioasid_t spid);
> > +
> > +
> > +Notifications
> > +-------------
> > +An IOASID may have multiple users, each user may have hardware context
> > +associated with an IOASID. When the status of an IOASID changes,
> > +e.g. an IOASID is being freed, users need to be notified such that the
> > +associated hardware context can be cleared, flushed, and drained.
> > +
> > +::
> > +
> > + int ioasid_register_notifier(struct ioasid_set *set, struct
> > +                              notifier_block *nb)
> > +
> > + void ioasid_unregister_notifier(struct ioasid_set *set,
> > +                                 struct notifier_block *nb)
> > +
> > + int ioasid_register_notifier_mm(struct mm_struct *mm, struct
> > +                                 notifier_block *nb)
> > +
> > + void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct
> > +                                    notifier_block *nb)
> > +
> > + int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd,
> > +                   unsigned int flags)
> > +
> > +"_mm" flavor of the ioasid_register_notifier() APIs are used when
> > +an IOASID user need to listen to the IOASID events belong to a
> > +process but without the knowledge of the associated ioasid_set.
> > +
> > +Events
> > +~~~~~~
> > +Notification events are pertinent to individual IOASIDs, they can be
> > +one of the following:
> > +
> > + - ALLOC
> > + - FREE
> > + - BIND
> > + - UNBIND
> > +
> > +Ordering
> > +~~~~~~~~
> > +Ordering is supported by IOASID notification priorities as the
> > +following (in ascending order):
> > +
> > +::
> > +
> > + enum ioasid_notifier_prios {
> > +	IOASID_PRIO_LAST,
> > +	IOASID_PRIO_IOMMU,
> > +	IOASID_PRIO_DEVICE,
> > +	IOASID_PRIO_CPU,
> > + };
> > +
> > +When registered, notifiers are assigned a priority that affect the
> > +call order. For example, notifiers with CPU priority get called before
> > +notifiers with device priority and so on.
> > +
> > +The typical use case is when an IOASID is freed due to an exception,
> > DMA +source should be quiesced before tearing down other hardware
> > contexts +in the system. This will reduce the churn in handling faults.
> > DMA work +submission is performed by the CPU which is granted higher
> > priority than +devices.
> > +
> > +Level Sensitivity
> > +~~~~~~~~~~~~~~~~~
> > +For each IOASID state transition, IOASID core ensures that there is
> > +only one notification sent. This resembles level triggered interrupt
> > +where a single interrupt is raised during a state transition.
> > +For example, if ioasid_free() is called twice by a user before the
> > +IOASID is reclaimed, IOASID core will only send out a single
> > +IOASID_NOTIFY_FREE event. Similarly, for IOASID_NOTIFY_BIND/UNBIND
> > +events, which is only sent out once when a SPID is attached/detached.
> > +
> > +IOASID notifications cannot be sent directly by IOASID users, they are
> > +sent out by the IOASID core as a by-product of the following APIs:
> > +- ioasid_alloc/free(), emit IOASID_NOTIFY_ALLOC/FREE
> > +- ioasid_attach/detach_spid() emit IOASID_NOTIFY_BIND/UNBIND
> > +
> > +Scopes
> > +~~~~~~
> > +There are two types of notifiers in IOASID core: system-wide and
> > +ioasid_set-wide.
> > +
> > +System-wide notifier is catering for users that need to handle all the
> > +IOASIDs in the system. E.g. The IOMMU driver.
> > +
> > +Per ioasid_set notifier can be used by VM specific components such as
> > +KVM. After all, each KVM instance only cares about IOASIDs within its
> > +own set/guest.
> > +
> > +
> > +Atomicity
> > +~~~~~~~~~
> > +IOASID notifiers are atomic due to spinlocks used inside the IOASID
> > +core. For tasks that cannot be completed in the notifier handler,
> > +async work can be submitted to complete the work later as long as
> > +there is no ordering requirement.
> > +
> > +Reference counting
> > +------------------
> > +IOASID lifecycle management is based on reference counting. Users of
> > +IOASID who intend to align lifecycle with the IOASID need to hold
> > +a reference of the IOASID. The IOASID will not be returned to the pool
> > +for allocation until all references are dropped. Calling ioasid_free()
> > +will mark the IOASID as FREE_PENDING if the IOASID has outstanding
> > +references. No new references can be taken by ioasid_get() once an
> > +IOASID is in the FREE_PENDING state. ioasid_free() can be called
> > +multiple times without an error until all refs are dropped.
> > +
> > +ioasid_put() decrements and tests refcount of the IOASID. If refcount
> > +is 0, ioasid will be freed. Deleted from the system-wide xarray as
> > +well as per set xarray.  
> 
> These xarray structures haven't been introduced so far. I would leave out
> this level of detail because it's not relevant to the user and will be
> difficult to keep in sync with the internals of IOASID.
> 
Right, I will deleted the xarray part.

> > The IOASID will be returned to the pool and
> > +available for new allocations.
> > +
> > +Event notifications are used to inform users of IOASID status change.
> > +IOASID_FREE event prompts users to drop their references after
> > +clearing its context.
> > +
> > +For example, on VT-d platform when an IOASID is freed, teardown
> > +actions are performed on KVM, device driver (VDCM), and the IOMMU
> > +driver. To quiesce VCPU for work submission, KVM notifier handler must
> > +be called before VDCM handler. Therefore, KVM and VDCM shall use
> > +notification priority IOASID_PRIO_CPU andIOASID_PRIO_DEVICE  
> 
>                                          and IOASID_PRIO_DEVICE
> 
go it.

> > +respectively.
> > +
> > +For both KVM and VDCM, notifier blocks shall be registered on the
> > +IOASID set such that *only* events from the matching VM are received.
> > +
> > +If KVM attempts to register a notifier block before the IOASID set is
> > +created using the MM token, the notifier block will be placed on a
> > +pending list inside IOASID core. Once the token matching IOASID set
> > +is created, IOASID will register the notifier block automatically.
> > +IOASID core does not replay events for the existing IOASIDs in the
> > +set. For IOASID set of MM type, notification blocks can be registered
> > +on empty sets only. This is to avoid lost events.
> > +
> > +IOMMU driver shall register notifier block on global chain::
> > +
> > + static struct notifier_block pasid_nb_vtd = {
> > +	.notifier_call = pasid_status_change_vtd,
> > +	.priority      = IOASID_PRIO_IOMMU,
> > + };
> > +
> > +Custom allocator APIs
> > +---------------------
> > +
> > +::
> > +
> > + int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
> > +
> > + void ioasid_unregister_allocator(struct ioasid_allocator_ops
> > *allocator); +
> > +Allocator Choices
> > +~~~~~~~~~~~~~~~~~
> > +IOASIDs are allocated for both host and guest SVA/IOVA usage. However,
> > +allocators can be different. For example, on VT-d guest PASID
> > +allocation must be performed via a virtual command interface which is
> > +emulated by VMM.
> > +
> > +IOASID core has the notion of "custom allocator" such that guest can
> > +register virtual command allocator that precedes the default one.  
> 
> "Supersedes", rather than "precedes"?
> 
My understanding is that 'supersede' means replace something but 'precede'
means get in front of something. I do want to emphasis that the custom
allocator takes precedence over the default allocator.

> > +
> > +Namespaces
> > +~~~~~~~~~~
> > +IOASIDs are limited system resources that default to 20 bits in
> > +size. Each device can have its own PASID table for security reasons.
> > +Theoretically the namespace can be per device also.
> > +
> > +However IOASID namespace is system-wide for two reasons:
> > +- Simplicity
> > +- Sharing resources of a single device to multiple VMs.
> > +
> > +Take VT-d as an example, VT-d supports shared workqueue and ENQCMD[1]
> > +where one IOASID could be used to submit work on multiple devices that
> > +are shared with other VMs. This requires IOASID to be
> > +system-wide. This is also the reason why guests must use an
> > +emulated virtual command interface to allocate IOASID from the host.
> > +
> > +Life cycle
> > +==========
> > +This section covers IOASID life cycle management for both bare-metal
> > +and guest usages. In bare-metal SVA, MMU notifier is directly hooked
> > +up with IOMMU driver, therefore the IOASID life cycle matches the
> > +process address space (MM) life cycle.
> > +
> > +However, guest MMU notifier is not available to host IOMMU driver,
> > +when guest MM terminates unexpectedly, the events have to go through
> > +VFIO and IOMMU UAPI to reach host IOMMU driver. There are also more
> > +parties involved in guest SVA, e.g. on Intel VT-d platform, IOASIDs
> > +are used by IOMMU driver, KVM, VDCM, and VFIO.
> > +
> > +Native IOASID Life Cycle (VT-d Example)
> > +---------------------------------------
> > +
> > +The normal flow of native SVA code with Intel Data Streaming
> > +Accelerator(DSA) [2] as example:
> > +
> > +1. Host user opens accelerator FD, e.g. DSA driver, or uacce;
> > +2. DSA driver allocate WQ, do sva_bind_device();
> > +3. IOMMU driver calls ioasid_alloc(), then bind PASID with device,
> > +   mmu_notifier_get()
> > +4. DMA starts by DSA driver userspace
> > +5. DSA userspace close FD
> > +6. DSA/uacce kernel driver handles FD.close()
> > +7. DSA driver stops DMA
> > +8. DSA driver calls sva_unbind_device();
> > +9. IOMMU driver does unbind, clears PASID context in IOMMU, flush
> > +   TLBs. mmu_notifier_put() called.
> > +10. mmu_notifier.release() called, IOMMU SVA code calls ioasid_free()*
> > +11. The IOASID is returned to the pool, reclaimed.
> > +
> > +::
> > +
> > +   * With ENQCMD, PASID used on VT-d is not released in mmu_notifier()
> > but
> > +     mmdrop(). mmdrop comes after FD close which does not make a
> > difference. +
> > +During the normal teardown, the following three key steps would happen
> > in +order: (7), (9), (11).
> > +
> > +Exception happens when process terminates *before* device driver stops
> > +DMA and call IOMMU driver to unbind. The detailed flow of process
> > +exits are as follows:
> > +
> > +::
> > +
> > +   do_exit() {
> > +	exit_mm() {
> > +		mm_put();
> > +		exit_mmap() {
> > +			intel_invalidate_range() //mmu notifier
> > +			tlb_finish_mmu()
> > +			mmu_notifier_release(mm) {
> > +				intel_mm_release() {
> > +   (9)
> > intel_iommu_teardown_pasid();
> > +                                        intel_iommu_flush_tlbs();
> > +				}
> > +				// tlb_invalidate_range cb removed
> > +			}
> > +			unmap_vmas();
> > +                        free_pgtables(); // IOMMU cannot walk PGT
> > after this  
> 
> or rather, it *must* not walk PGT at this point? PGT should be disabled on
> the IOMMU side at step 9, before the TLB invalidation
> 
Yes, agreed already guaranteed. I will delete the comment.

> > +		};
> > +	}
> > +	exit_files(tsk) {
> > +		close_files() {
> > +			dsa_close();
> > +   (7)			dsa_stop_dma();
> > +                        intel_svm_unbind_pasid(); //nothing to do
> > +		}
> > +	}
> > +   }
> > +
> > +   mmdrop() /* some random time later, lazy mm user */ {
> > +   	mm_free_pgd();
> > +        destroy_context(mm); {
> > +   (11)	        ioasid_free();
> > +	}
> > +   }
> > +
> > +As shown in the list above, step #2 could happen before
> > +#1. Unrecoverable(UR) faults could happen between #2 and #1.
> > +Fault processing is disabled by the IOMMU driver in #2, therefore the
> > UR +fault never reaches the driver.  
> 
> Did you mean steps (7) and (9) instead for #1 and #2?
> 
Yes, forgot to update the index.

> > +
> > +
> > +Also notice that TLB invalidation occurs at mmu_notifier
> > +invalidate_range callback as well as the release callback. The reason
> > +is that release callback will delete IOMMU driver from the notifier
> > +chain which may skip invalidate_range() calls during the exit path.  
> 
> I think this whole section also goes too deep in implementation details,
> and is susceptible to become out of sync with the code pretty quickly.
> I don't feel strongly about this, though, leave it if you want.
> 
I will delete this, better be accurate than misleading.

> > +
> > +To avoid unnecessary reporting of UR fault, IOMMU driver shall disable
> > +fault reporting after free and before unbind.
> > +
> > +Guest IOASID Life Cycle (VT-d Example)
> > +--------------------------------------
> > +Guest IOASID life cycle starts with guest driver open(), this could be
> > +uacce or individual accelerator driver such as DSA. At FD open,
> > +sva_bind_device() is called which triggers a series of actions.
> > +
> > +The example below is an illustration of *normal* operations that
> > +involves *all* the SW components in VT-d. The flow can be simpler if
> > +no ENQCMD is supported.
> > +
> > +::
> > +
> > +     VFIO        IOMMU        KVM        VDCM        IOASID       Ref
> > +   ..................................................................
> > +   1             ioasid_register_notifier/_mm()
> > +   2 ioasid_alloc()                                               1
> > +   3 bind_gpasid()
> > +   4             iommu_bind()->ioasid_get()                       2
> > +   5             ioasid_notify(BIND)
> > +   6                          -> ioasid_get()                     3
> > +   7                          -> vmcs_update_atomic()
> > +   8 mdev_write(gpasid)
> > +   9                                    hpasid=
> > +   10                                   find_by_spid(gpasid)      4  
> 
> Are 9 and 10 the same step?
> 
yes, here is just line #.

> > +   11                                   vdev_write(hpasid)  
> 
> What's the 'v' in vdev? Aren't we writing to the physical device here?
> 
Yes, we are writing to the physical resource of the virtual device. Let me
remove the 'v'.

> > +   12 -------- GUEST STARTS DMA --------------------------
> > +   13 -------- GUEST STOPS DMA --------------------------
> > +   14 mdev_clear(gpasid)
> > +   15                                   vdev_clear(hpasid)
> > +   16                                   ioasid_put()               3
> > +   17 unbind_gpasid()
> > +   18            iommu_ubind()
> > +   19            ioasid_notify(UNBIND)
> > +   20                          -> vmcs_update_atomic()
> > +   21                          -> ioasid_put()                     2
> > +   22 ioasid_free()                                                1
> > +   23            ioasid_put()                                      0
> > +   24                                                 Reclaimed
> > +   -------------- New Life Cycle Begin ----------------------------
> > +   1  ioasid_alloc()                                  ->           1
> > +
> > +   Note: IOASID Notification Events: FREE, BIND, UNBIND  
> 
> Is FREE at step 22?
> 
Yes the IOASID_FREE event should be sent at step 22, let me call it out
explicitly.

> > +
> > +Exception cases arise when a guest crashes or a malicious guest
> > +attempts to cause disruption on the host system. The fault handling
> > +rules are:
> > +
> > +1. IOASID free must *always* succeed.
> > +2. An inactive period may be required before the freed IOASID is
> > +   reclaimed. During this period, consumers of IOASID perform cleanup.
> > +3. Malfunction is limited to the guest owned resources for all
> > +   programming errors.
> > +
> > +The primary source of exception is when the following are out of
> > +order:
> > +
> > +1. Start/Stop of DMA activity
> > +   (Guest device driver, mdev via VFIO)
> > +2. Setup/Teardown of IOMMU PASID context, IOTLB, DevTLB flushes
> > +   (Host IOMMU driver bind/unbind)
> > +3. Setup/Teardown of VMCS PASID translation table entries (KVM) in
> > +   case of ENQCMD
> > +4. Programming/Clearing host PASID in VDCM (Host VDCM driver)
> > +5. IOASID alloc/free (Host IOASID)
> > +
> > +VFIO is the *only* user-kernel interface, which is ultimately
> > +responsible for exception handling.
> > +
> > +#1 is processed the same way as the assigned device today based on
> > +device file descriptors and events. There is no special handling.
> > +
> > +#3 is based on bind/unbind events emitted by #2.
> > +
> > +#4 is naturally aligned with IOASID life cycle in that an illegal
> > +guest PASID programming would fail in obtaining reference of the
> > +matching host IOASID.
> > +
> > +#5 is similar to #4. The fault will be reported to the user if PASID
> > +used in the ENQCMD is not set up in VMCS PASID translation table.
> > +
> > +Therefore, the remaining out of order problem is between #2 and
> > +#5. I.e. unbind vs. free. More specifically, free before unbind.
> > +
> > +IOASID notifier and refcounting are used to ensure order. Following
> > +a publisher-subscriber pattern where:
> > +
> > +- Publishers: VFIO & IOMMU
> > +- Subscribers: KVM, VDCM, IOMMU
> > +
> > +IOASID reference must be acquired before receiving the FREE event. The
> > +reference must be dropped at the end of the processing in order to
> > +return the IOASID to the pool.
> > +
> > +Let's examine the IOASID life cycle again when free happens *before*
> > +unbind. This could be a result of misbehaving guests or crash. Assuming
> > +VFIO cannot enforce unbind->free order. Notice that the setup part up
> > +until step #12 is identical to the normal case, the flow below starts
> > +with step 13.
> > +
> > +::
> > +
> > +     VFIO        IOMMU        KVM        VDCM        IOASID       Ref
> > +   ..................................................................
> > +   13 -------- GUEST STARTS DMA --------------------------
> > +   14 -------- *GUEST MISBEHAVES!!!* ----------------
> > +   15 ioasid_free()
> > +   16                                             ioasid_notify(FREE)
> > +   17                                             mark_free_pending
> > (1)  
> 
> Could we use superscript ¹²³⁴ for footnotes? These look like function
> parameters
> 
yes, much better

> > +   18                          kvm_nb_handler(FREE)
> > +   19                          vmcs_update_atomic()
> > +   20                          ioasid_put_locked()   ->           3
> > +   21                                   vdcm_nb_handler(FREE)
> > +   22            iomm_nb_handler(FREE)  
> 
> iommu_nb_handler
> 
got it

> > +   23 ioasid_free() returns(2)          schedule_work()           2  
> 
> I completely lost track here, couldn't figure out in which direction to
> read the diagram. What work is scheduled?
The time line goes downward but we only control the notification order in
terms of when the events are received. Some completions are async thus out
of order done by work items. The only in-order completion is the KVM update
of its PASID translation table.

After #23, the async works are scheduled to complete clean up work outside
the spinlock(held by the caller of the atomic notifier).

Any suggestions to improve the readability of the time line?

> Why does the IOMMU driver drop
> its reference to the IOASID before unbdind_gpasid()?
> 
This is the exception case where userspace issues IOASID free before
unbind_gpasid(). The equivalent of unbind is performed in the IOASID_FREE
notification handler. In IOASID_FREE handler, reference is dropped and
private data deleted. After that, if unbind comes to IOMMU driver, it will
not find IOASID private data therefore just return.

> > +   24            schedule_work()        vdev_clear_wk(hpasid)
> > +   25            teardown_pasid_wk()
> > +   26                                   ioasid_put() ->           1
> > +   27            ioasid_put()                                     0
> > +   28                                                 Reclaimed
> > +   29 unbind_gpasid()
> > +   30            iommu_unbind()->ioasid_find() Fails(3)
> > +   -------------- New Life Cycle Begin ----------------------------
> > +
> > +Note:
> > +
> > +1. By marking IOASID FREE_PENDING at step #17, no new references can be
> > +   held. ioasid_get/find() will return -ENOENT;  
> 
> s/held/taken
> 
Got it.

> Thanks,
> Jean
> 
> > +2. After step #23, all events can go out of order. Shall not affect
> > +   the outcome.
> > +3. IOMMU driver fails to find private data for unbinding. If unbind is
> > +   called after the same IOASID is allocated for the same guest again,
> > +   this is a programming error. The damage is limited to the guest
> > +   itself since unbind performs permission checking based on the
> > +   IOASID set associated with the guest process.
> > +4. Workqueues are used by VDCM and IOMMU driver for processing that
> > +   requires thread context.
> > +
> > +
> > +KVM PASID Translation Table Updates
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Per VM PASID translation table is maintained by KVM in order to
> > +support ENQCMD in the guest. The table contains host-guest PASID
> > +translations to be consumed by CPU ucode. The synchronization of the
> > +PASID states depends on VFIO/IOMMU driver, where IOCTL and atomic
> > +notifiers are used. KVM must register IOASID notifier per VM instance
> > +during launch time. The following events are handled:
> > +
> > +1. BIND/UNBIND
> > +2. FREE
> > +
> > +Rules:
> > +
> > +1. Multiple devices can bind with the same PASID, this can be
> > different PCI
> > +   devices or mdevs within the same PCI device. However, only the
> > +   *first* BIND and *last* UNBIND emit notifications.
> > +2. IOASID code is responsible for ensuring the correctness of H-G
> > +   PASID mapping. There is no need for KVM to validate the
> > +   notification data.
> > +3. When UNBIND happens *after* FREE, KVM will see error in
> > +   ioasid_get() even when the reclaim is not done. IOMMU driver will
> > +   also avoid sending UNBIND if the PASID is already FREE.
> > +4. When KVM terminates *before* FREE & UNBIND, references will be
> > +   dropped for all host PASIDs.
> > +
> > +VDCM PASID Programming
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +VDCM composes virtual devices and exposes them to the guests. When
> > +the guest allocates a PASID then program it to the virtual device, VDCM
> > +intercepts the programming attempt then programs the matching host
> > +PASID on to the hardware.
> > +Conversely, when a device is going away, VDCM must be informed such
> > +that PASID context on the hardware can be cleared. There could be
> > +multiple mdevs assigned to different guests in the same VDCM. Since
> > +the PASID table is shared at PCI device level, lazy clearing is not
> > +secure. A malicious guest can attack by using newly freed PASIDs that
> > +are allocated by another guest.
> > +
> > +By holding a reference of the PASID until VDCM cleans up the HW
> > context, +it is guaranteed that PASID life cycles do not cross within
> > the same +device.
> > +
> > +
> > +Reference
> > +====================================================
> > +1.
> > https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> > + +2.
> > https://01.org/blogs/2019/introducing-intel-data-streaming-accelerator +
> > +3.
> > https://software.intel.com/en-us/download/intel-data-streaming-accelerator-preliminary-architecture-specification
> > -- 2.7.4
> >   


Thanks,

Jacob

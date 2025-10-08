Return-Path: <linux-api+bounces-5022-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE1EBC3886
	for <lists+linux-api@lfdr.de>; Wed, 08 Oct 2025 09:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B528189D829
	for <lists+linux-api@lfdr.de>; Wed,  8 Oct 2025 07:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439802F1FC0;
	Wed,  8 Oct 2025 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4CLiF6F"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465792F0C6D
	for <linux-api@vger.kernel.org>; Wed,  8 Oct 2025 07:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759907055; cv=none; b=ExPOXnuBr2q6Z/QzsFoxEFHXx+cMphiyF0C9imG/hGyshAfFtxJkQ8N/ixtfojOrSEZL8Uhqh40ye3fyJyXMHOiO0aGok4czDxTjl5HB6JFOmfX6+SwHbH0e2V71yFDQ5fXh1z0UGbdMmyqmIyOBS+TEa20gnMLz2SuetO8UaGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759907055; c=relaxed/simple;
	bh=/GbuQkuDNR0smyhVeZXvUoVOJNV+5FL2qiigjo7yspo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7eyPYG9VuaUD+GHJMqSqekk5+0+TUayvDg0qS0XKWIP7Ki1WsIUSIqWEqIGB7my3Lu2ORhFGwLFEBR18GHhXcOzKpSjzDwAndVXeI2feJ0sJmo2Du4h3QpOlF0pqZIfvGhz5E1MkixykQSFkqF/Bz1NQu9oQiPPxrZhG8CnNGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4CLiF6F; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4e6ec0d1683so159281cf.0
        for <linux-api@vger.kernel.org>; Wed, 08 Oct 2025 00:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759907051; x=1760511851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPCHBZ1+/7LiLJckiEnwJaZfBghJo0RvCO3Y5uD53wo=;
        b=B4CLiF6Figh5oBsptxipQcJrfoHUMisD+0Iw/gee+79h+97umCSutby3pdtSNAQ9jx
         mUgMjq8eL9b9TF8DMJEv1wO16xM/RxvHZFLCX8cS/vU8JhwfeOuPC5gR4I+vTOdvelNg
         7Eq0N9xD55xuK/M1JjxkoY8B7s5KEhp9qFCa1asos3hy/WOuVVAvnue5VpJHij8nIcY1
         cTrQErj7Tnx0E1Ea/hka5HHt16SAoBMrohHmarngBz717dmFWthSwqou32jWhV3rJGoK
         ni0yHvmuEnmtEDF92PX9zZd6ALFP3zBEm4RUi/iq2DxjK5+Uff51HJF58SNwr80NKXX0
         QHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759907051; x=1760511851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPCHBZ1+/7LiLJckiEnwJaZfBghJo0RvCO3Y5uD53wo=;
        b=Xry3mYl3s33CKfQ/m4te/3owToEVdKrGSl+crBr92a6ixJXg8PUcUVTlZPzLhCNAFP
         R+BRWtyq9xToGus2Qe2mOp55Y0RhYjHj0tyb9NNuFnrL+nzxCg5M6IShSTW8pEfR1CXO
         bR7+q9cT8K1ODlWARZw25dWXlQWTytqSt4T7LIRVxfyQF4N6GhXEF1DKBz2FVJprWWyI
         UHSqu4grARf1jlj4ae4qjzIcEeN/nc3hQlO0DQ1MTbCMm46OdkkxmeFL565+e9IIUd6P
         oYpx9xz9XBU/Gg64K/Z+evXx8AwMGWmt5ThYFE6boGjECR05jjF2CxeDBi5C4Qq/2DRd
         8GSg==
X-Forwarded-Encrypted: i=1; AJvYcCWWKB+YnSYKo9EoB1bMazTamVaGUYf08uKsYFqTsLlW3Q39TKMLA8D5v3vlqOaJFS00o+qu9fAR06E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC2IleApVChRaPAXYZQ8dlU4q3aHyU/B3NDGXKBcgD/CWX3w+Z
	i6//ixlgPQaWAnZNt+DuF5iVFjbmi+9JQBdK3SNXucytTvbT4poeokDL6pgOz5UtQS2YbmJsSOD
	e27gjdmJFfTcesRE0hVFKHDGjMAyLE2/JCHmsiNS6
X-Gm-Gg: ASbGncs1VKh3Nb6dtylVDXstHz8ct8wOZK93eLDljY/06JsIThQPa10DKgbO+FLaIst
	JM4v9QGU4cYNtix0pApf/J7DYGoVqDrD509DwO6Mq+NhYH0ecLdiJhiXRS4JUleut1AUPzkX3uO
	HEVtrRCvRoYkDQWgSioTfmsxPWmPSkLdCZpPJdZvQn/B3hgecYf7nwEu+HD0sStM/i/Gi0bA8gK
	E5MNfnPrldRIYnIWp7JP22qTeSvLH7+uF8HIVM4bNm7Mx4V6P7+mMUGDwBkuz/bc5MsE+5RwCP2
	K6X3pA==
X-Google-Smtp-Source: AGHT+IESBNxpmlHAcig1IJkHHF05YX821iqOxoDV74weoqPTYVJz+7JZa7+j9bKX361CFoQRAxX2np/+3jTAYoYjULA=
X-Received: by 2002:a05:622a:14cd:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4e6eab2eacfmr4994001cf.8.1759907049795; Wed, 08 Oct 2025
 00:04:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com> <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
In-Reply-To: <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 8 Oct 2025 00:03:58 -0700
X-Gm-Features: AS18NWCS-g05IhVhTIM2Iz76DqP2Hm1WLW7pFPt_MogdzxJ745tyFKTSuojklQE
Message-ID: <CAAywjhSP=ugnSJOHPGmTUPGh82wt+qnaqZAqo99EfhF-XHD5Sg@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	changyuanl@google.com, rppt@kernel.org, dmatlack@google.com, 
	rientjes@google.com, corbet@lwn.net, rdunlap@infradead.org, 
	ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, ojeda@kernel.org, 
	aliceryhl@google.com, masahiroy@kernel.org, akpm@linux-foundation.org, 
	tj@kernel.org, yoann.congal@smile.fr, mmaurer@google.com, 
	roman.gushchin@linux.dev, chenridong@huawei.com, axboe@kernel.dk, 
	mark.rutland@arm.com, jannh@google.com, vincent.guittot@linaro.org, 
	hannes@cmpxchg.org, dan.j.williams@intel.com, david@redhat.com, 
	joel.granados@kernel.org, rostedt@goodmis.org, anna.schumaker@oracle.com, 
	song@kernel.org, zhangguopeng@kylinos.cn, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 10:11=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Sun, Sep 28, 2025 at 9:03=E2=80=AFPM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > This series introduces the Live Update Orchestrator (LUO), a kernel
> > subsystem designed to facilitate live kernel updates. LUO enables
> > kexec-based reboots with minimal downtime, a critical capability for
> > cloud environments where hypervisors must be updated without disrupting
> > running virtual machines. By preserving the state of selected resources=
,
> > such as file descriptors and memory, LUO allows workloads to resume
> > seamlessly in the new kernel.
> >
> > The git branch for this series can be found at:
> > https://github.com/googleprodkernel/linux-liveupdate/tree/luo/v4
> >
> > The patch series applies against linux-next tag: next-20250926
> >
> > While this series is showed cased using memfd preservation. There are
> > works to preserve devices:
> > 1. IOMMU: https://lore.kernel.org/all/20250928190624.3735830-16-skhawaj=
a@google.com
> > 2. PCI: https://lore.kernel.org/all/20250916-luo-pci-v2-0-c494053c3c08@=
kernel.org
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Changelog since v3:
> > (https://lore.kernel.org/all/20250807014442.3829950-1-pasha.tatashin@so=
leen.com):
> >
> > - The main architectural change in this version is introduction of
> >   "sessions" to manage the lifecycle of preserved file descriptors.
> >   In v3, session management was left to a single userspace agent. This
> >   approach has been revised to improve robustness. Now, each session is
> >   represented by a file descriptor (/dev/liveupdate). The lifecycle of
> >   all preserved resources within a session is tied to this FD, ensuring
> >   automatic cleanup by the kernel if the controlling userspace agent
> >   crashes or exits unexpectedly.
> >
> > - The first three KHO fixes from the previous series have been merged
> >   into Linus' tree.
> >
> > - Various bug fixes and refactorings, including correcting memory
> >   unpreservation logic during a kho_abort() sequence.
> >
> > - Addressing all comments from reviewers.
> >
> > - Removing sysfs interface (/sys/kernel/liveupdate/state), the state
> >   can now be queried  only via ioctl() API.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Hi all,
>
> Following up on yesterday's Hypervisor Live Update meeting, we
> discussed the requirements for the LUO to track dependencies,
> particularly for IOMMU preservation and other stateful file
> descriptors. This email summarizes the main design decisions and
> outcomes from that discussion.
>
> For context, the notes from the previous meeting can be found here:
> https://lore.kernel.org/all/365acb25-4b25-86a2-10b0-1df98703e287@google.c=
om
> The notes for yesterday's meeting are not yes available.
>
> The key outcomes are as follows:
>
> 1. User-Enforced Ordering
> -------------------------
> The responsibility for enforcing the correct order of operations will
> lie with the userspace agent. If fd_A is a dependency for fd_B,
> userspace must ensure that fd_A is preserved before fd_B. This same
> ordering must be honored during the restoration phase after the reboot
> (fd_A must be restored before fd_B). The kernel preserve the ordering.
>
> 2. Serialization in PRESERVE_FD
> -------------------------------
> To keep the global prepare() phase lightweight and predictable, the
> consensus was to shift the heavy serialization work into the
> PRESERVE_FD ioctl handler. This means that when userspace requests to
> preserve a file, the file handler should perform the bulk of the
> state-saving work immediately.
>
> The proposed sequence of operations reflects this shift:
>
> Shutdown Flow:
> fd_preserve() (heavy serialization) -> prepare() (lightweight final
> checks) -> Suspend VM -> reboot(KEXEC) -> freeze() (lightweight)
>
> Boot & Restore Flow:
> fd_restore() (lightweight object creation) -> Resume VM -> Heavy
> post-restore IOCTLs (e.g., hardware page table re-creation) ->
> finish() (lightweight cleanup)
>
> This decision primarily serves as a guideline for file handler
> implementations. For the LUO core, this implies minor API changes,
> such as renaming can_preserve() to a more active preserve() and adding
> a corresponding unpreserve() callback to be called during
> UNPRESERVE_FD.
>
> 3. FD Data Query API
> --------------------
> We identified the need for a kernel API to allow subsystems to query
> preserved FD data during the boot process, before userspace has
> initiated the restore.
>
> The proposed API would allow a file handler to retrieve a list of all
> its preserved FDs, including their session names, tokens, and the
> private data payload.
>
> Proposed Data Structure:
>
> struct liveupdate_fd {
>         char *session; /* session name */
>         u64 token; /* Preserved FD token */
>         u64 data; /* Private preserved data */
> };
>
> Proposed Function:
> liveupdate_fd_data_query(struct liveupdate_file_handler *h,
>                          struct liveupdate_fd *fds, long *count);
>
> 4. New File-Lifecycle-Bound Global State
> ----------------------------------------
> A new mechanism for managing global state was proposed, designed to be
> tied to the lifecycle of the preserved files themselves. This would
> allow a file owner (e.g., the IOMMU subsystem) to save and retrieve
> global state that is only relevant when one or more of its FDs are
> being managed by LUO.
>
> The key characteristics of this new mechanism are:
> The global state is optionally created on the first preserve() call
> for a given file handler.
> The state can be updated on subsequent preserve() calls.
> The state is destroyed when the last corresponding file is unpreserved
> or finished.
> The data can be accessed during boot.
>
> I am thinking of an API like this.
>
> 1. Add three more callbacks to liveupdate_file_ops:

This part is a little tricky, the file handler might be in a
completely different subsystem as compared to the global state. While
FD is supposed to own and control the lifecycle of the preserved
state, the global state might be needed in a completely different
layer during boot or some other event. Maybe the user can put some
APIs in place to move this state across layers?

Subsystems actually do provide this flexibility. But If I see
correctly, this approach is "global" like a subsystem but synchronous.
Users can decide when to preserve/create global state when they need
without the need to stage it and preserve it when subsystem PREPARE is
called.
> /*
>  * Optional. Called by LUO during first get global state call.
>  * The handler should allocate/KHO preserve its global state object and r=
eturn a
>  * pointer to it via 'obj'. It must also provide a u64 handle (e.g., a ph=
ysical
>  * address of preserved memory) via 'data_handle' that LUO will save.
>  * Return: 0 on success.
>  */
> int (*global_state_create)(struct liveupdate_file_handler *h,
>                            void **obj, u64 *data_handle);
>
> /*
>  * Optional. Called by LUO in the new kernel
>  * before the first access to the global state. The handler receives
>  * the preserved u64 data_handle and should use it to reconstruct its
>  * global state object, returning a pointer to it via 'obj'.
>  * Return: 0 on success.
>  */
> int (*global_state_restore)(struct liveupdate_file_handler *h,
>                             u64 data_handle, void **obj);

If I understand correctly, is this only for unpacking? Once unpacked
the user can call the _get function and get the global state that it
just unpacked. This should be fine.
>
> /*
>  * Optional. Called by LUO after the last
>  * file for this handler is unpreserved or finished. The handler
>  * must free its global state object and any associated resources.
>  */
> void (*global_state_destroy)(struct liveupdate_file_handler *h, void *obj=
);
>
> The get/put global state data:
>
> /* Get and lock the data with file_handler scoped lock */
> int liveupdate_fh_global_state_get(struct liveupdate_file_handler *h,
>                                    void **obj);
>
> /* Unlock the data */
> void liveupdate_fh_global_state_put(struct liveupdate_file_handler *h);
>
> Execution Flow:
> 1. Outgoing Kernel (First preserve() call):
> 2. Handler's preserve() is called. It needs the global state, so it calls
>    liveupdate_fh_global_state_get(&h, &obj). LUO acquires h->global_state=
_lock.
>    It sees h->global_state_obj is NULL.
>    LUO calls h->ops->global_state_create(h, &h->global_state_obj, &handle=
).
>    The handler allocates its state, preserves it with KHO, and returns it=
s live
>    pointer and a u64 handle.
> 3. LUO stores the handle internally for later serialization.
> 4. LUO sets *obj =3D h->global_state_obj and returns 0 with the lock stil=
l held.
> 5. The preserve() callback does its work using the obj.
> 6. It calls liveupdate_fh_global_state_put(h), which releases the lock.
>
> Global PREPARE:
> 1. LUO iterates handlers. If h->count > 0, it writes the stored data_hand=
le into
>    the LUO FDT.
>
> Incoming Kernel (First access):
> 1. When liveupdate_fh_global_state_get(&h, &obj) is called the first time=
. LUO
>    acquires h->global_state_lock.
> 2. It sees h->global_state_obj is NULL, but it knows it has a preserved u=
64
>    handle from the FDT. LUO calls h->ops->global_state_restore()
> 3. Reconstructs its state object, and returns the live pointer.
> 4. LUO sets *obj =3D h->global_state_obj and returns 0 with the lock held=
.
> 5. The caller does its work.
> 6. It calls liveupdate_fh_global_state_put(h) to release the lock.
>
> Last File Cleanup (in unpreserve or finish):
> 1. LUO decrements h->count to 0.
> 2. This triggers the cleanup logic.
> 3. LUO calls h->ops->global_state_destroy(h, h->global_state_obj).
> 4. The handler frees its memory and resources.
> 5. LUO sets h->global_state_obj =3D NULL, resetting it for a future live =
update
>    cycle.
>
> Pasha
>
>
> Pasha


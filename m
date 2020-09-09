Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D92E263037
	for <lists+linux-api@lfdr.de>; Wed,  9 Sep 2020 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIIPJh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Sep 2020 11:09:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730093AbgIIL7a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Sep 2020 07:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599652741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3UaBeQLwySDgbYv1//ym4a5uQWApJgjQehsNp+Ge+U=;
        b=KPdYL86qQ1mB+8T1GYWg3w8ckuAMOfjmGuolxjQKdv/nspY2uOw2JN7SHWOkiDNmBtkzb4
        5Tlz+K3vG2CUgCtCgmBy6Iry6cKcUcyDr0KSALXymXos+1zGcE8eJPMRiwy3O7VN0BkojL
        jKMOvLKnjC6nBOO/w33hxCCskAnv8Mw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-Otv-oQy-PLWyX_LQoEpklg-1; Wed, 09 Sep 2020 07:38:59 -0400
X-MC-Unique: Otv-oQy-PLWyX_LQoEpklg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16407873085;
        Wed,  9 Sep 2020 11:38:57 +0000 (UTC)
Received: from localhost (ovpn-112-226.ams2.redhat.com [10.36.112.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DAC25D9E8;
        Wed,  9 Sep 2020 11:38:52 +0000 (UTC)
Date:   Wed, 9 Sep 2020 12:38:51 +0100
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20200909113851.GB15584@stefanha-x1.localdomain>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200907150547.hst4luvrpntdb3lr@wittgenstein>
 <CALCETrUSUp_7svg8EHNTk3nQ0x9sdzMCU=h8G-Sy6=SODq5GHg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrUSUp_7svg8EHNTk3nQ0x9sdzMCU=h8G-Sy6=SODq5GHg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 07, 2020 at 01:43:48PM -0700, Andy Lutomirski wrote:
> On Mon, Sep 7, 2020 at 8:05 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Laz=C4=83r wrote:
> > > This patchset adds support for the remote mapping feature.
> > > Remote mapping, as its name suggests, is a means for transparent and
> > > zero-copy access of a remote process' address space.
> > > access of a remote process' address space.
> > >
> > > The feature was designed according to a specification suggested by
> > > Paolo Bonzini:
> > > >> The proposed API is a new pidfd system call, through which the par=
ent
> > > >> can map portions of its virtual address space into a file descript=
or
> > > >> and then pass that file descriptor to a child.
> > > >>
> > > >> This should be:
> > > >>
> > > >> - upstreamable, pidfd is the new cool thing and we could sell it a=
s a
> > > >> better way to do PTRACE_{PEEK,POKE}DATA
> >
> > In all honesty, that sentence made me a bit uneasy as it reads like thi=
s
> > is implemented on top of pidfds because it makes it more likely to go
> > upstream not because it is the right design. To be clear, I'm not
> > implying any sort of malicious intent on your part but I would suggest
> > to phrase this a little better. :)
>=20
>=20
> I thought about this whole thing some more, and here are some thoughts.
>=20
> First, I was nervous about two things.  One was faulting in pages from
> the wrong context.  (When a normal page fault or KVM faults in a page,
> the mm is loaded.  (In the KVM case, the mm is sort of not loaded when
> the actual fault happens, but the mm is loaded when the fault is
> handled, I think.  Maybe there are workqueues involved and I'm wrong.)
>  When a remote mapping faults in a page, the mm is *not* loaded.)
> This ought not to be a problem, though -- get_user_pages_remote() also
> faults in pages from a non-current mm, and that's at least supposed to
> work correctly, so maybe this is okay.
>=20
> Second is recursion.  I think this is a genuine problem.
>=20
> And I think that tying this to pidfds is the wrong approach.  In fact,
> tying it to processes at all seems wrong.  There is a lot of demand
> for various forms of memory isolation in which memory is mapped only
> by its intended user.  Using something tied to a process mm gets in
> the way of this in the same way that KVM's current mapping model gets
> in the way.
>=20
> All that being said, I think the whole idea of making fancy address
> spaces composed from other mappable objects is neat and possibly quite
> useful.  And, if you squint a bit, this is a lot like what KVM does
> today.
>=20
> So I suggest something that may be more generally useful as an
> alternative.  This is a sketch and very subject to bikeshedding:
>=20
> Create an empty address space:
>=20
> int address_space_create(int flags, etc);
>=20
> Map an fd into an address space:
>=20
> int address_space_mmap(int asfd, int fd_to_map, offset, size, prot,
> ...);  /* might run out of args here */
>=20
> Unmap from an address space:
>=20
> int address_space_munmap(int asfd, unsigned long addr, unsigned long len)=
;
>=20
> Stick an address space into KVM:
>=20
> ioctl(vmfd, KVM_MAP_ADDRESS_SPACE, asfd);  /* or similar */
>=20
> Maybe some day allow mapping an address space into a process.
>=20
> mmap(..., asfd, ...);
>=20
>=20
> And at least for now, there's a rule that an address space that is
> address_space_mmapped into an address space is disallowed.
>=20
>=20
> Maybe some day we also allow mremap(), madvise(), etc.  And maybe some
> day we allow creating a special address_space that represents a real
> process's address space.
>=20
>=20
> Under the hood, an address_space could own an mm_struct that is not
> used by any tasks.  And we could have special memfds that are bound to
> a VM such that all you can do with them is stick them into an
> address_space and map that address_space into the VM in question.  For
> this to work, we would want a special vm_operation for mapping into a
> VM.
>=20
>=20
> What do you all think?  Is this useful?  Does it solve your problems?
> Is it a good approach going forward?

Hi Adalbert and Andy,
As everyone continues to discuss how the mechanism should look, I want
to share two use cases for something like this. Let me know if you would
like more detail on these use cases.

They requirement in both cases is that process A can map a virtual
memory range from process B so that mmap/munmap operations within the
memory range in process B also affect process A.

An enforcing vIOMMU for vhost-user and vfio-user
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
vhost-user, vfio-user, and other out-of-process device emulation
interfaces need a way for the virtual machine manager (VMM) to enforce
the vIOMMU mappings on the device emulation process. The VMM emulates
the vIOMMU and only wants to expose a subset of memory to the device
emulation process. This subset can change as the guest programs the
vIOMMU.

Today the VMM passes all guest RAM fds to the device emulation process
and has no way of restricting access or revoking it later.

The new mechanism would allow the VMM to add/remove mappings so that the
device emulation process can only access ranges of memory programmed by
the guest vIOMMU. Accesses to unmapped addresses would raise a signal.

Accelerating the virtio-fs DAX window
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The virtiofsd vhost-user process handles guest file map/unmap messages.
The map/unmap messages allow the guest to map ranges of files into its
memory space. The guest kernel then uses DAX to access the file pages
without copying their contents into the guest page cache and mmap
MAP_SHARED is coherent when guests access the same file.

Today virtiofsd sends a message to the VMM over a UNIX domain socket
asking for an mmap/munmap. The VMM must perform the mapping on behalf of
virtiofsd. This communication and file descriptor passing is clumsy and
slow.

The new mechanism would allow virtiofsd to map/unmap without extra
coordination with the VMM. The VMM only needs to perform an initial mmap
of the DAX window so that kvm.ko can resolve page faults to that region.

Stefan

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9YvssACgkQnKSrs4Gr
c8jgmAgAuJ0jppeoVYZkdUALumrBuzhXCQHDvchy1ZDTx/LXIOH5qdykOl5yDwbX
1Nnd+ADNa1DURY4ugsfdUexIi6ggJKZ0IlK0p4YO9JRvKnB6Db9chzUd5tylhAac
YfOfIh+AHojv2O144RUoPwMIFebDTd+ZIWNnDe3yufSJ/eXFFoA6TXSQoEfyxjTM
DPUHgbxDjXqciDD+m5S/oOPv6b/Krkce4aR/+KAFX3erP9Jea2FYbRK3ID6Dly9r
B8307HMKuIvxlPTFsp1PgRTni/jwTraGvKRq9Pk4SgLoz3Cu0smDOQI93PyRvGf9
0ewFaj+4BoTulmHbxK8hXHA666AUaA==
=+lbr
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--


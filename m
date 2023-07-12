Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3167510C9
	for <lists+linux-api@lfdr.de>; Wed, 12 Jul 2023 20:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGLSy5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jul 2023 14:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGLSyz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jul 2023 14:54:55 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D161B1FD8;
        Wed, 12 Jul 2023 11:54:50 -0700 (PDT)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id E6A38C85; Wed, 12 Jul 2023 13:54:48 -0500 (CDT)
Date:   Wed, 12 Jul 2023 13:54:48 -0500
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
Message-ID: <20230712185448.GA611149@mail.hallyn.com>
References: <20211216112659.310979-1-brauner@kernel.org>
 <20211216112659.310979-2-brauner@kernel.org>
 <20211226133140.GA8064@mail.hallyn.com>
 <0e817424-51db-fe0b-a00e-ac7933e8ac1d@siemens.com>
 <20220530081358.b3tvgvo63mq5o2oo@wittgenstein>
 <202205311219.725ED1C69@keescook>
 <20220602104107.6b3d3udhslvhg6ew@wittgenstein>
 <08b4b0c8-3621-a970-d206-d24e6eb81355@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b4b0c8-3621-a970-d206-d24e6eb81355@siemens.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 28, 2023 at 07:20:28AM +0100, Jan Kiszka wrote:
> On 02.06.22 12:41, Christian Brauner wrote:
> > On Tue, May 31, 2022 at 12:24:37PM -0700, Kees Cook wrote:
> >> On Mon, May 30, 2022 at 10:13:58AM +0200, Christian Brauner wrote:
> >>> On Sun, May 29, 2022 at 09:35:40PM +0200, Jan Kiszka wrote:
> >>>> On 26.12.21 14:31, Serge E. Hallyn wrote:
> >>>>> On Thu, Dec 16, 2021 at 12:26:59PM +0100, Christian Brauner wrote:
> >>>>>> From: Christian Brauner <christian.brauner@ubuntu.com>
> >>>>>>
> >>>>>> Enable unprivileged sandboxes to create their own binfmt_misc mounts.
> >>>>>> This is based on Laurent's work in [1] but has been significantly
> >>>>>> reworked to fix various issues we identified in earlier versions.
> >>>>>>
> >>>>>> While binfmt_misc can currently only be mounted in the initial user
> >>>>>> namespace, binary types registered in this binfmt_misc instance are
> >>>>>> available to all sandboxes (Either by having them installed in the
> >>>>>> sandbox or by registering the binary type with the F flag causing the
> >>>>>> interpreter to be opened right away). So binfmt_misc binary types are
> >>>>>> already delegated to sandboxes implicitly.
> >>>>>>
> >>>>>> However, while a sandbox has access to all registered binary types in
> >>>>>> binfmt_misc a sandbox cannot currently register its own binary types
> >>>>>> in binfmt_misc. This has prevented various use-cases some of which were
> >>>>>> already outlined in [1] but we have a range of issues associated with
> >>>>>> this (cf. [3]-[5] below which are just a small sample).
> >>>>>>
> >>>>>> Extend binfmt_misc to be mountable in non-initial user namespaces.
> >>>>>> Similar to other filesystem such as nfsd, mqueue, and sunrpc we use
> >>>>>> keyed superblock management. The key determines whether we need to
> >>>>>> create a new superblock or can reuse an already existing one. We use the
> >>>>>> user namespace of the mount as key. This means a new binfmt_misc
> >>>>>> superblock is created once per user namespace creation. Subsequent
> >>>>>> mounts of binfmt_misc in the same user namespace will mount the same
> >>>>>> binfmt_misc instance. We explicitly do not create a new binfmt_misc
> >>>>>> superblock on every binfmt_misc mount as the semantics for
> >>>>>> load_misc_binary() line up with the keying model. This also allows us to
> >>>>>> retrieve the relevant binfmt_misc instance based on the caller's user
> >>>>>> namespace which can be done in a simple (bounded to 32 levels) loop.
> >>>>>>
> >>>>>> Similar to the current binfmt_misc semantics allowing access to the
> >>>>>> binary types in the initial binfmt_misc instance we do allow sandboxes
> >>>>>> access to their parent's binfmt_misc mounts if they do not have created
> >>>>>> a separate binfmt_misc instance.
> >>>>>>
> >>>>>> Overall, this will unblock the use-cases mentioned below and in general
> >>>>>> will also allow to support and harden execution of another
> >>>>>> architecture's binaries in tight sandboxes. For instance, using the
> >>>>>> unshare binary it possible to start a chroot of another architecture and
> >>>>>> configure the binfmt_misc interpreter without being root to run the
> >>>>>> binaries in this chroot and without requiring the host to modify its
> >>>>>> binary type handlers.
> >>>>>>
> >>>>>> Henning had already posted a few experiments in the cover letter at [1].
> >>>>>> But here's an additional example where an unprivileged container
> >>>>>> registers qemu-user-static binary handlers for various binary types in
> >>>>>> its separate binfmt_misc mount and is then seamlessly able to start
> >>>>>> containers with a different architecture without affecting the host:
> >>>>>>
> >>>>>> root    [lxc monitor] /var/snap/lxd/common/lxd/containers f1
> >>>>>> 1000000  \_ /sbin/init
> >>>>>> 1000000      \_ /lib/systemd/systemd-journald
> >>>>>> 1000000      \_ /lib/systemd/systemd-udevd
> >>>>>> 1000100      \_ /lib/systemd/systemd-networkd
> >>>>>> 1000101      \_ /lib/systemd/systemd-resolved
> >>>>>> 1000000      \_ /usr/sbin/cron -f
> >>>>>> 1000103      \_ /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
> >>>>>> 1000000      \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
> >>>>>> 1000104      \_ /usr/sbin/rsyslogd -n -iNONE
> >>>>>> 1000000      \_ /lib/systemd/systemd-logind
> >>>>>> 1000000      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
> >>>>>> 1000107      \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
> >>>>>> 1000000      \_ [lxc monitor] /var/lib/lxc f1-s390x
> >>>>>> 1100000          \_ /usr/bin/qemu-s390x-static /sbin/init
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-journald
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/sbin/cron -f
> >>>>>> 1100103              \_ /usr/bin/qemu-s390x-static /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-ac
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
> >>>>>> 1100104              \_ /usr/bin/qemu-s390x-static /usr/sbin/rsyslogd -n -iNONE
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-logind
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
> >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-udevd
> >>>>>>
> >>>>>> [1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
> >>>>>> [2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
> >>>>>> [3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
> >>>>>> [4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
> >>>>>> [5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11
> >>>>>>
> >>>>>> Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu (origin)
> >>>>>> Link: https://lore.kernel.org/r/20211028103114.2849140-2-brauner@kernel.org (v1)
> >>>>>> Cc: Sargun Dhillon <sargun@sargun.me>
> >>>>>> Cc: Serge Hallyn <serge@hallyn.com>
> >>>>>
> >>>>> (one typo below)
> >>>>>
> >>>>> Acked-by: Serge Hallyn <serge@hallyn.com>
> >>>>>
> >>>>
> >>>> What happened to this afterwards? Any remaining issues?
> >>>
> >>> Not that we know. I plan to queue this up for 5.20.
> >>
> >> Hello!
> >>
> >> Thanks for the thread-ping -- I hadn't had a chance to read through this
> >> before, but since it's touching binfmt, it popped up on my radar. :)
> >>
> >> I like it overall, though I'd rather see it split up more (there's
> >> some refactoring built into the patches that would be nice to split out
> >> just to make review easier), but since others have already reviewed it,
> >> that's probably overkill.
> >>
> >> I'd really like to see some self-tests for this, though. Especially
> > 
> > Yeah, I had started writing them but decoupled the upstreaming. Imho,
> > you can start queueing this up. I'd like this to have very long exposure
> > in -next. I'll follow up with selftests in the next weeks. (I'm out for
> > a conference this week.)
> > 
> >> around the cred logic changes and the namespace fallback logic. I'd like
> >> to explicitly document and test what the expectations are around the
> >> mounts, etc.
> >>
> >> Finally, I'd prefer this went via the execve tree.
> > 
> > I mentioned this yesterday to you but just so there's a paper trail:
> > The series and this iteration preceeds the maintainer entry. That's the
> > only reason this originally wasn't aimed at that tree when the series
> > was sent. You've been in Cc from the start though. :)
> > I'd like to step up and maintain the binfmt_misc fs going forward. There
> > are other tweaks it could use.
> > 
> 
> Did anything happen after this? I'm not finding traced in lkml at least.
> 
> Jan

Looking at https://lore.kernel.org/all/20230630-hufen-herzallerliebst-fde8e7aecba0@brauner/
looks like Christian was going to ping Kees about taking
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.binfmt_misc

-serge

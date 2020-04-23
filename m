Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C721B6516
	for <lists+linux-api@lfdr.de>; Thu, 23 Apr 2020 22:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgDWUDo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Apr 2020 16:03:44 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:48310 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgDWUDo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 23 Apr 2020 16:03:44 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 9DC5F20459;
        Thu, 23 Apr 2020 20:03:38 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH v13 0/8] proc: modernize proc to support multiple private instances
Date:   Thu, 23 Apr 2020 22:03:08 +0200
Message-Id: <20200423200316.164518-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 23 Apr 2020 20:03:39 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Preface:
--------
This is patch set v13 to modernize procfs and make it able to support multiple
private instances per the same pid namespace.

This patch set can be applied on top of:

git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v5.7-rc1-299-gc21cca0fb71d


Procfs modernization:
---------------------
Historically procfs was always tied to pid namespaces, during pid
namespace creation we internally create a procfs mount for it. However,
this has the effect that all new procfs mounts are just a mirror of the
internal one, any change, any mount option update, any new future
introduction will propagate to all other procfs mounts that are in the
same pid namespace.

This may have solved several use cases in that time. However today we
face new requirements, and making procfs able to support new private
instances inside same pid namespace seems a major point. If we want to
to introduce new features and security mechanisms we have to make sure
first that we do not break existing usecases. Supporting private procfs
instances will allow to support new features and behaviour without
propagating it to all other procfs mounts.

Today procfs is more of a burden especially to some Embedded, IoT,
sandbox, container use cases. In user space we are over-mounting null
or inaccessible files on top to hide files and information. If we want
to hide pids we have to create PID namespaces otherwise mount options
propagate to all other proc mounts, changing a mount option value in one
mount will propagate to all other proc mounts. If we want to introduce
new features, then they will propagate to all other mounts too, resulting
either maybe new useful functionality or maybe breaking stuff. We have
also to note that userspace should not workaround procfs, the kernel
should just provide a sane simple interface.

In this regard several developers and maintainers pointed out that
there are problems with procfs and it has to be modernized:

"Here's another one: split up and modernize /proc." by Andy Lutomirski [1]

Discussion about kernel pointer leaks:

"And yes, as Kees and Daniel mentioned, it's definitely not just dmesg.
In fact, the primary things tend to be /proc and /sys, not dmesg
itself." By Linus Torvalds [2]

Lot of other areas in the kernel and filesystems have been updated to be
able to support private instances, devpts is one major example [3].

Which will be used for:

1) Embedded systems and IoT: usually we have one supervisor for
apps, we have some lightweight sandbox support, however if we create
pid namespaces we have to manage all the processes inside too,
where our goal is to be able to run a bunch of apps each one inside
its own mount namespace, maybe use network namespaces for vlans
setups, but right now we only want mount namespaces, without all the
other complexity. We want procfs to behave more like a real file system,
and block access to inodes that belong to other users. The 'hidepid=' will
not work since it is a shared mount option.

2) Containers, sandboxes and Private instances of file systems - devpts case
Historically, lot of file systems inside Linux kernel view when instantiated
were just a mirror of an already created and mounted filesystem. This was the
case of devpts filesystem, it seems at that time the requirements were to
optimize things and reuse the same memory, etc. This design used to work but not
anymore with today's containers, IoT, hostile environments and all the privacy
challenges that Linux faces.

In that regards, devpts was updated so that each new mounts is a total
independent file system by the following patches:

"devpts: Make each mount of devpts an independent filesystem" by
Eric W. Biederman [3] [4]

3) Linux Security Modules have multiple ptrace paths inside some
subsystems, however inside procfs, the implementation does not guarantee
that the ptrace() check which triggers the security_ptrace_check() hook
will always run. We have the 'hidepid' mount option that can be used to
force the ptrace_may_access() check inside has_pid_permissions() to run.
The problem is that 'hidepid' is per pid namespace and not attached to
the mount point, any remount or modification of 'hidepid' will propagate
to all other procfs mounts.

This also does not allow to support Yama LSM easily in desktop and user
sessions. Yama ptrace scope which restricts ptrace and some other
syscalls to be allowed only on inferiors, can be updated to have a
per-task context, where the context will be inherited during fork(),
clone() and preserved across execve(). If we support multiple private
procfs instances, then we may force the ptrace_may_access() on
/proc/<pids>/ to always run inside that new procfs instances. This will
allow to specifiy on user sessions if we should populate procfs with
pids that the user can ptrace or not.

By using Yama ptrace scope, some restricted users will only be able to see
inferiors inside /proc, they won't even be able to see their other
processes. Some software like Chromium, Firefox's crash handler, Wine
and others are already using Yama to restrict which processes can be
ptracable. With this change this will give the possibility to restrict
/proc/<pids>/ but more importantly this will give desktop users a
generic and usuable way to specifiy which users should see all processes
and which user can not.

Side notes:

* This covers the lack of seccomp where it is not able to parse
arguments, it is easy to install a seccomp filter on direct syscalls
that operate on pids, however /proc/<pid>/ is a Linux ABI using
filesystem syscalls. With this change all LSMs should be able to analyze
open/read/write/close... on /proc/<pid>/

4) This will allow to implement new features either in kernel or
userspace without having to worry about procfs.
In containers, sandboxes, etc we have workarounds to hide some /proc
inodes, this should be supported natively without doing extra complex
work, the kernel should be able to support sane options that work with
today and future Linux use cases.

5) Creation of new superblock with all procfs options for each procfs
mount will fix the ignoring of mount options. The problem is that the
second mount of procfs in the same pid namespace ignores the mount
options. The mount options are ignored without error until procfs is
remounted.

Before:

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=2 0 0

# strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
+++ exited with 0 +++

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=2 0 0
proc /tmp/proc proc rw,relatime,hidepid=2 0 0

# mount -o remount,hidepid=1 -t proc proc /tmp/proc

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=1 0 0
proc /tmp/proc proc rw,relatime,hidepid=1 0 0

After:

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=ptraceable 0 0

# mount -o hidepid=invisible -t proc proc /tmp/proc

# grep ^proc /proc/mounts
proc /proc proc rw,relatime,hidepid=ptraceable 0 0
proc /tmp/proc proc rw,relatime,hidepid=invisible 0 0


Introduced changes:
-------------------
Each mount of procfs creates a separate procfs instance with its own
mount options.

This series adds few new mount options:

* New 'hidepid=ptraceable' or 'hidepid=4' mount option to show only ptraceable
processes in the procfs. This allows to support lightweight sandboxes in
Embedded Linux, also solves the case for LSM where now with this mount option,
we make sure that they have a ptrace path in procfs.

* 'subset=pid' that allows to hide non-pid inodes from procfs. It can be used
in containers and sandboxes, as these are already trying to hide and block
access to procfs inodes anyway.


ChangeLog:
----------
# v13:
* Fix a crash caused by accessing proc_pidns directly through superblock.

# v12:
* Rebase on top of v5.7-rc1.
* Fix a resource leak if proc is not mounted or if proc is simply reconfigured.
* Add few selftests.

# v11:
* After a discussion with Eric W. Biederman, the numerical values for hidepid 
  parameter have been removed from uapi.
* Remove proc_self and proc_thread_self from the pid_namespace struct.
* I took into account the comment of Kees Cook.
* Update Reviewed-by tags.

# v10:
* 'subset=pidfs' renamed to 'subset=pid' as suggested by Alexey Dobriyan.
* Include Reviewed-by tags.

# v9:
* Rebase on top of Eric W. Biederman's procfs changes.
* Add human readable values of 'hidepid' as suggested by Andy Lutomirski.

# v8:
* Started using RCU lock to clean dcache entries as suggested by Linus Torvalds.

# v7:
* 'pidonly=1' renamed to 'subset=pidfs' as suggested by Alexey Dobriyan.
* HIDEPID_* moved to uapi/ as they are user interface to mount().
  Suggested-by Alexey Dobriyan <adobriyan@gmail.com>

# v6:
* 'hidepid=' and 'gid=' mount options are moved from pid namespace to superblock.
* 'newinstance' mount option removed as suggested by Eric W. Biederman.
   Mount of procfs always creates a new instance.
* 'limit_pids' renamed to 'hidepid=3'.
* I took into account the comment of Linus Torvalds [7].
* Documentation added.

# v5:
* Fixed a bug that caused a problem with the Fedora boot.
* The 'pidonly' option is visible among the mount options.

# v2:
* Renamed mount options to 'newinstance' and 'pids='
   Suggested-by: Andy Lutomirski <luto@kernel.org>
* Fixed order of commit, Suggested-by: Andy Lutomirski <luto@kernel.org>
* Many bug fixes.

# v1:
* Removed 'unshared' mount option and replaced it with 'limit_pids'
   which is attached to the current procfs mount.
   Suggested-by Andy Lutomirski <luto@kernel.org>
* Do not fill dcache with pid entries that we can not ptrace.
* Many bug fixes.


References:
-----------
[1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-January/004215.html
[2] http://www.openwall.com/lists/kernel-hardening/2017/10/05/5
[3] https://lwn.net/Articles/689539/
[4] http://lxr.free-electrons.com/source/Documentation/filesystems/devpts.txt?v=3.14
[5] https://lkml.org/lkml/2017/5/2/407
[6] https://lkml.org/lkml/2017/5/3/357
[7] https://lkml.org/lkml/2018/5/11/505


Alexey Gladkov (8):
  proc: rename struct proc_fs_info to proc_fs_opts
  Use proc_pid_ns() to get pid_namespace from the proc superblock
  proc: allow to mount many instances of proc in one pid namespace
  proc: instantiate only pids that we can ptrace on 'hidepid=4' mount
    option
  proc: add option to mount only a pids subset
  docs: proc: add documentation for "hidepid=4" and "subset=pid" options
    and new mount behavior
  proc: use human-readable values for hidepid
  proc: use named enums for better readability

 Documentation/filesystems/proc.rst            |  92 +++++++++---
 fs/locks.c                                    |   4 +-
 fs/proc/base.c                                |  48 +++++--
 fs/proc/generic.c                             |   9 ++
 fs/proc/inode.c                               |  30 +++-
 fs/proc/root.c                                | 131 +++++++++++++-----
 fs/proc/self.c                                |   6 +-
 fs/proc/thread_self.c                         |   6 +-
 fs/proc_namespace.c                           |  14 +-
 include/linux/pid_namespace.h                 |  12 --
 include/linux/proc_fs.h                       |  30 +++-
 security/tomoyo/realpath.c                    |   4 +-
 tools/testing/selftests/proc/.gitignore       |   2 +
 tools/testing/selftests/proc/Makefile         |   2 +
 .../selftests/proc/proc-fsconfig-hidepid.c    |  50 +++++++
 .../selftests/proc/proc-multiple-procfs.c     |  48 +++++++
 16 files changed, 389 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/proc/proc-fsconfig-hidepid.c
 create mode 100644 tools/testing/selftests/proc/proc-multiple-procfs.c

-- 
2.25.3


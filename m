Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A207231CD3
	for <lists+linux-api@lfdr.de>; Wed, 29 Jul 2020 12:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2Kjj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jul 2020 06:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2Kjh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jul 2020 06:39:37 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D48BC061794;
        Wed, 29 Jul 2020 03:39:37 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l2so10591777wrc.7;
        Wed, 29 Jul 2020 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=VCsTo9/FVTsGIGizruMEEp8UoKR+A6R6KxZ640I77oE=;
        b=PSePVPS5slYhQyZ/zP11H2OorRd2yZYHkGHtelq/7Rgq7xCwcpNZKZEktz11ro+A0P
         7BpalRERibCNF35tWkYYx7sWw2FHM8fxmtZiBWge52iIUD4ZsnpWJC1Z4cDGDNfiFSEW
         kRz5ZX/LW9BCbnuTckeBkcBvjMHHIlPNrQ1pZ1N+4OxxNMOxjkumnMXr/HLkWd1mg0fR
         2Nj+gT9n2M3ufaKsST50AXw/n72qKLWebRzTpuv1KLAU96YBAvoHNcpwH56UamqWhaGl
         Krs8cL182yrVx5KMr8JJXd0+B2naNSLUsVRvNR1bQaFroe1u7jGgn7+M4a3vXazBYFCh
         Q8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=VCsTo9/FVTsGIGizruMEEp8UoKR+A6R6KxZ640I77oE=;
        b=WB93YFFnat41PrMQYQEPnz/1TWxvp/9pG34qf7ZWLx1WZ3JRnwbn5Mu9kPDDaDLeeF
         yzdZSx6ohcvpGFNNVh/6HKAEhcq6qtewnCr7j9i3nBxuytkj2NPTeOs6OQ8+ISPm4eBN
         Zalh73+PSTyNJFYP1LV4tcHIberxlnYrHQ9Veg0uFvAP2bbtsuSB9uzvOpmolBs5KQHy
         SKDBHn+tyKLPOyTjJOv7PHWPRlYD1JGIxdpk1dpsiqpOziTPY7qQnkUVb3AeJe/fjea2
         qNUIjW4SEtjULYmbt2JKq4FQQzc0IS28LEJwUGbkILqJUg8TFoK2q3MlzAOcseZ2L4Oh
         XMTw==
X-Gm-Message-State: AOAM532m1ieECNkdxtiE690NqC1E6zfFNjpJMect6Um22HD6Mhcg2A9l
        OSEyryMln+Uv7P50ruJXCQzwnO1q
X-Google-Smtp-Source: ABdhPJwBcmooy/eyYQSqOcafnv4ZXYMJVSaYfnKzXsOjWwWzNzi0Cnc78OQ3vbdbKJ6AQWNxux0xuQ==
X-Received: by 2002:adf:f488:: with SMTP id l8mr28362809wro.123.1596019175037;
        Wed, 29 Jul 2020 03:39:35 -0700 (PDT)
Received: from ?IPv6:2001:a61:3adb:8201:9649:88f:51f8:6a21? ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id c136sm4284609wmd.10.2020.07.29.03.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 03:39:34 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Joseph Myers <joseph@codesourcery.com>,
        Linux API <linux-api@vger.kernel.org>
To:     "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>, enh <enh@google.com>,
        Zack Weinberg <zackw@panix.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: [RFC PATCH] Replacing "master-slave" terminology for pseudoterminals
Message-ID: <b3b4cf95-5eaa-0b4e-34cc-1a855e7148b6@gmail.com>
Date:   Wed, 29 Jul 2020 12:39:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As per some discussion on libc-alpha [1], many of us are interested in
finding a replacement for the problemantic master-slave terminology
used in the description of pseudoterminals.

Elliot Hughes (enh@) suggested a replacement based on an idea from 
an analogous change in the golang libraries, and I've taken a shot 
at implementing that idea in a branch [2] of man-pages. The affected
pages are:

 man2/ioctl_tty.2    | 23 +++++++++++--------
 man2/poll.2         |  3 ++-
 man3/getpt.3        |  2 +-
 man3/grantpt.3      | 17 +++++++-------
 man3/openpty.3      | 35 ++++++++++++++++------------
 man3/posix_openpt.3 | 10 ++++----
 man3/ptsname.3      | 10 ++++----
 man3/ttyname.3      |  2 +-
 man3/unlockpt.3     | 11 +++++----
 man4/pts.4          | 26 ++++++++++++---------
 man7/pty.7          | 65 +++++++++++++++++++++++++++-------------------------
 11 files changed, 112 insertions(+), 92 deletions(-)

Eventually, I think we should take this discussion also to the 
mailing list, and also see if we can raise this within the POSIX 
committee. But let's see if we can fist off find some terminology
that seems agreeable.

I've added the full patch below. I am myself still reflecting on 
the change. At times, the language feels a little clunky, but overall
I don't hate the result. I welcome comments from all, and especially
I'd be interested in feedback from Elliot and from Zack, who was 
planning to work on this issue in the glibc documentation.

Thanks,

Michael

[1] https://sourceware.org/pipermail/libc-alpha/2020-July/115792.html
[2] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=pty_lang_fixup


commit 05af4e7c070e4fa6fa810954264d5650b85d162e
Author: Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Tue Jul 28 22:12:08 2020 +0200

    ioctl_tty.2, poll.2, getpt.3, grantpt.3, openpty.3, posix_openpt.3, ptsname.3, ttyname.3, unlockpt.3, pts.4, pty.7: Eliminate problematic "master-slave" terminology
    
    The "master-slave" terminology used in describing pseudoterminals
    is problematic, and not even very technically descriptive. Rewrite
    various manual pages to eliminate that language. The following
    replacement terms are used:
    
    slave ==> "terminal device"
           (or "terminal end of the pseudoterminal device pair")
    
    master ==> "pseudoterminal device"
           (or "pseudoterminal end of the pseudoterminal device pair")
    
    pseudoterminal (device) ==> "pseudoterminal device pair"
    
    Another notable wording change is the use of phrasings such as
    "the corresponding terminal device", when emphasizing the linkage
    between the pseudoterminal and terminal ends of a pseudoterminal
    device pair.
    
    The terminology originates in golang (which made a similar
    terminology change in 2019), and was suggested for Linux
    man-pages by Elliot Hughes.
    
    Reported-by: Elliott Hughes <enh@google.com>
    Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>

diff --git a/man2/ioctl_tty.2 b/man2/ioctl_tty.2
index 88ec0269a..7f504928e 100644
--- a/man2/ioctl_tty.2
+++ b/man2/ioctl_tty.2
@@ -220,7 +220,8 @@ Redirect output that would have gone to
 or
 .I /dev/tty0
 to the given terminal.
-If that was a pseudoterminal master, send it to the slave.
+If that was the pseudoterminal end of a pseudoterminal device pair,
+send it to the corresponding terminal device.
 In Linux before version 2.6.10,
 anybody can do this as long as the output was not redirected yet;
 since version 2.6.10, only a process with the
@@ -283,7 +284,7 @@ Set the foreground process group ID of this terminal.
 Get the session ID of the given terminal.
 This fails with the error
 .B ENOTTY
-if the terminal is not a master pseudoterminal
+if the terminal is not the pseudoterminal end of a pseudoterminal device pair
 and not our controlling terminal.
 Strange.
 .SS Exclusive mode
@@ -322,14 +323,15 @@ Set the line discipline of the terminal.
 Enable (when
 .RI * argp
 is nonzero) or disable packet mode.
-Can be applied to the master side of a pseudoterminal only (and will return
+Can be applied only to the pseudoterminal end of a pseudoterminal device pair
+(and will return
 .B ENOTTY
 otherwise).
 In packet mode, each subsequent
 .BR read (2)
 will return a packet that either contains a single nonzero control byte,
 or has a single byte containing zero (\(aq\e0\(aq) followed by data
-written on the slave side of the pseudoterminal.
+written on the terminal end of the pseudoterminal device pair.
 If the first byte is not
 .B TIOCPKT_DATA
 (0), it is an OR of one
@@ -346,7 +348,7 @@ TIOCPKT_NOSTOP      The start and stop characters are not \fB^S\fP/\fB^Q\fP.
 .IP
 While packet mode is in use, the presence
 of control status information to be read
-from the master side may be detected by a
+from the pseudoterminal end of the device pair may be detected by a
 .BR select (2)
 for exceptional conditions or a
 .BR poll (2)
@@ -371,13 +373,14 @@ Set (if
 .IR *argp
 is nonzero) or remove (if
 .IR *argp
-is zero) the lock on the pseudoterminal slave device.
+is zero) the lock on the terminal end of a pseudoterminal device pair.
 (See also
 .BR unlockpt (3).)
 .TP
 .BI "TIOCGPTLCK	int *" argp
 (since Linux 3.8)
-Place the current lock state of the pseudoterminal slave device
+Place the current lock state of the terminal end of
+a pseudoterminal device pair
 in the location pointed to by
 .IR argp .
 .TP
@@ -386,14 +389,14 @@ in the location pointed to by
 (since Linux 4.13)
 Given a file descriptor in
 .I fd
-that refers to a pseudoterminal master,
+that refers to the pseudoterminal end of a pseudoterminal device pair,
 open (with the given
 .BR open (2)-style
 .IR flags )
 and return a new file descriptor that refers to the peer
-pseudoterminal slave device.
+terminal device.
 This operation can be performed
-regardless of whether the pathname of the slave device
+regardless of whether the pathname of the terminal device
 is accessible through the calling process's mount namespace.
 .IP
 Security-conscious programs interacting with namespaces may wish to use this
diff --git a/man2/poll.2 b/man2/poll.2
index 940c51da5..b4428e9f6 100644
--- a/man2/poll.2
+++ b/man2/poll.2
@@ -172,7 +172,8 @@ Possibilities include:
 There is out-of-band data on a TCP socket (see
 .BR tcp (7)).
 .IP \(bu
-A pseudoterminal master in packet mode has seen a state change on the slave
+A pseudoterminal device in packet mode has seen a state change on
+the corresponding terminal device
 (see
 .BR ioctl_tty (2)).
 .IP \(bu
diff --git a/man3/getpt.3 b/man3/getpt.3
index 89c3813a8..65904596d 100644
--- a/man3/getpt.3
+++ b/man3/getpt.3
@@ -6,7 +6,7 @@
 .\"
 .TH GETPT 3 2020-02-09 "GNU" "Linux Programmer's Manual"
 .SH NAME
-getpt \- open a new pseudoterminal master
+getpt \- open a new pseudoterminal device
 .SH SYNOPSIS
 .nf
 .BR "#define _GNU_SOURCE" "             /* See feature_test_macros(7) */"
diff --git a/man3/grantpt.3 b/man3/grantpt.3
index 34c59a52b..c09d50685 100644
--- a/man3/grantpt.3
+++ b/man3/grantpt.3
@@ -4,7 +4,7 @@
 .\"
 .TH GRANTPT 3 2017-09-15 "GNU" "Linux Programmer's Manual"
 .SH NAME
-grantpt \- grant access to the slave pseudoterminal
+grantpt \- grant access to the terminal device corresponding to a pseudoterminal
 .SH SYNOPSIS
 .B #include <stdlib.h>
 .PP
@@ -30,13 +30,14 @@ Glibc 2.23 and earlier:
 .SH DESCRIPTION
 The
 .BR grantpt ()
-function changes the mode and owner of the slave pseudoterminal device
-corresponding to the master pseudoterminal referred to by the file descriptor
+function changes the mode and owner of the terminal device
+corresponding to the pseudoterminal device referred to by the file descriptor
 .IR fd .
-The user ID of the slave is set to the real UID of the calling process.
+The user ID of the terminal device
+is set to the real UID of the calling process.
 The group ID is set to an unspecified value (e.g.,
 .IR tty ).
-The mode of the slave is set to 0620 (crw\-\-w\-\-\-\-).
+The mode of the terminal device is set to 0620 (crw\-\-w\-\-\-\-).
 .PP
 The behavior of
 .BR grantpt ()
@@ -53,7 +54,7 @@ appropriately.
 .SH ERRORS
 .TP
 .B EACCES
-The corresponding slave pseudoterminal could not be accessed.
+The corresponding terminal device could not be accessed.
 .TP
 .B EBADF
 The
@@ -63,7 +64,7 @@ argument is not a valid open file descriptor.
 .B EINVAL
 The
 .I fd
-argument is valid but not associated with a master pseudoterminal.
+argument is valid but not associated with a pseudoterminal device.
 .SH VERSIONS
 .BR grantpt ()
 is provided in glibc since version 2.1.
@@ -90,7 +91,7 @@ Many systems implement this function via a set-user-ID helper binary
 called "pt_chown".
 On Linux systems with a devpts filesystem (present since Linux 2.2),
 the kernel normally sets the correct ownership and permissions
-for the pseudoterminal slave when the master is opened
+for the corresponding terminal device when the pseudoterminal device is opened
 .RB ( posix_openpt (3)),
 so that nothing must be done by
 .BR grantpt ().
diff --git a/man3/openpty.3 b/man3/openpty.3
index 9d3dcc236..8580dc9a4 100644
--- a/man3/openpty.3
+++ b/man3/openpty.3
@@ -38,11 +38,11 @@ openpty, login_tty, forkpty \- terminal utility functions
 .nf
 .B #include <pty.h>
 .PP
-.BI "int openpty(int *" amaster ", int *" aslave ", char *" name ,
+.BI "int openpty(int *" fd_pty ", int *" fd_tty ", char *" name ,
 .BI "            const struct termios *" termp ,
 .BI "            const struct winsize *" winp );
 .PP
-.BI "pid_t forkpty(int *" amaster ", char *" name ,
+.BI "pid_t forkpty(int *" fd_pty ", char *" name ,
 .BI "              const struct termios *" termp ,
 .BI "              const struct winsize *" winp );
 
@@ -55,23 +55,26 @@ Link with \fI\-lutil\fP.
 .SH DESCRIPTION
 The
 .BR openpty ()
-function finds an available pseudoterminal and returns file descriptors
-for the master and slave in
-.I amaster
+function finds an available pseudoterminal device pair
+and returns file descriptors
+for the pseudoterminal device and the corresponding terminal device in
+.I fd_pty
 and
-.IR aslave .
+.IR fd_tty .
 If
 .I name
-is not NULL, the filename of the slave is returned in
+is not NULL, the filename of the corresponding terminal device is returned in
 .IR name .
 If
 .I termp
-is not NULL, the terminal parameters of the slave will be set to the
+is not NULL, the terminal parameters of the corresponding terminal device
+will be set to the
 values in
 .IR termp .
 If
 .I winp
-is not NULL, the window size of the slave will be set to the values in
+is not NULL, the window size of the corresponding terminal device
+will be set to the values in
 .IR winp .
 .PP
 The
@@ -79,7 +82,8 @@ The
 function prepares for a login on the terminal
 referred to by the file descriptor
 .I fd
-(which may be a real terminal device, or the slave of a pseudoterminal as
+(which may be a real terminal device,
+or the terminal end of a pseudoterminal device pair as
 returned by
 .BR openpty ())
 by creating a new session, making
@@ -99,19 +103,20 @@ and
 .BR login_tty ()
 to create a new process operating in a pseudoterminal.
 A file descriptor referring to
-master side of the pseudoterminal is returned in
-.IR amaster .
+the pseudoterminal end of the pseudoterminal device pair
+is returned in
+.IR fd_pty .
 If
 .I name
 is not NULL, the buffer it points to is used to return the
-filename of the slave.
+filename of the corresponding terminal device.
 The
 .I termp
 and
 .I winp
 arguments, if not NULL,
-will determine the terminal attributes and window size of the slave
-side of the pseudoterminal.
+will determine the terminal attributes and window size of the terminal end
+of the pseudoterminal device pair.
 .SH RETURN VALUE
 If a call to
 .BR openpty (),
diff --git a/man3/posix_openpt.3 b/man3/posix_openpt.3
index 6feaae03d..a932cc9f0 100644
--- a/man3/posix_openpt.3
+++ b/man3/posix_openpt.3
@@ -45,7 +45,7 @@ _XOPEN_SOURCE\ >=\ 600
 .SH DESCRIPTION
 The
 .BR posix_openpt ()
-function opens an unused pseudoterminal master device, returning a
+function opens an unused pseudoterminal device, returning a
 file descriptor that can be used to refer to that device.
 .PP
 The
@@ -109,10 +109,12 @@ posix_openpt(int flags)
 .PP
 Calling
 .BR posix_openpt ()
-creates a pathname for the corresponding pseudoterminal slave device.
-The pathname of the slave device can be obtained using
+creates a pathname for the terminal device that corresponds
+to the pseudoterminal.
+The pathname of the terminal device can be obtained using
 .BR ptsname (3).
-The slave device pathname exists only as long as the master device is open.
+The terminal device pathname exists only as long as
+the pseudoterminal device is open.
 .SH SEE ALSO
 .BR open (2),
 .BR getpt (3),
diff --git a/man3/ptsname.3 b/man3/ptsname.3
index 5ae25c5e4..eb3d16cac 100644
--- a/man3/ptsname.3
+++ b/man3/ptsname.3
@@ -6,7 +6,7 @@
 .\"
 .TH PTSNAME 3 2020-06-09 "" "Linux Programmer's Manual"
 .SH NAME
-ptsname, ptsname_r \- get the name of the slave pseudoterminal
+ptsname, ptsname_r \- get the name of the terminal corresponding to a pseudoterminal
 .SH SYNOPSIS
 .B #include <stdlib.h>
 .PP
@@ -37,15 +37,15 @@ Glibc 2.23 and earlier:
 .SH DESCRIPTION
 The
 .BR ptsname ()
-function returns the name of the slave pseudoterminal device
-corresponding to the master referred to by the file descriptor
+function returns the name of the terminal device
+corresponding to the pseudoterminal device referred to by the file descriptor
 .IR fd .
 .PP
 The
 .BR ptsname_r ()
 function is the reentrant equivalent of
 .BR ptsname ().
-It returns the name of the slave pseudoterminal device as a
+It returns the name of the terminal device as a
 null-terminated string in the buffer pointed to by
 .IR buf .
 The
@@ -79,7 +79,7 @@ glibc 2.25 and earlier.)
 .TP
 .B ENOTTY
 .I fd
-does not refer to a pseudoterminal master device.
+does not refer to a pseudoterminal device.
 .TP
 .B ERANGE
 .RB ( ptsname_r ()
diff --git a/man3/ttyname.3 b/man3/ttyname.3
index 93932610b..cd9831522 100644
--- a/man3/ttyname.3
+++ b/man3/ttyname.3
@@ -67,7 +67,7 @@ Bad file descriptor.
 .\" glibc commit 15e9a4f378c8607c2ae1aa465436af4321db0e23
 .B ENODEV
 .I fd
-refers to a slave pseudoterminal device
+refers to the terminal end of a pseudoterminal device pair
 but the corresponding pathname could not be found (see NOTES).
 .TP
 .B ENOTTY
diff --git a/man3/unlockpt.3 b/man3/unlockpt.3
index 26333ef6d..c3d67f4a2 100644
--- a/man3/unlockpt.3
+++ b/man3/unlockpt.3
@@ -4,7 +4,7 @@
 .\"
 .TH UNLOCKPT 3 2017-07-13 "" "Linux Programmer's Manual"
 .SH NAME
-unlockpt \- unlock a pseudoterminal master/slave pair
+unlockpt \- unlock a pseudoterminal device pair
 .SH SYNOPSIS
 .B #define _XOPEN_SOURCE
 .br
@@ -32,12 +32,13 @@ Glibc 2.23 and earlier:
 .SH DESCRIPTION
 The
 .BR unlockpt ()
-function unlocks the slave pseudoterminal device
-corresponding to the master pseudoterminal referred to by the file descriptor
+function unlocks the terminal device
+corresponding to the pseudoterminal device referred to by the file descriptor
 .IR fd .
 .PP
 .BR unlockpt ()
-should be called before opening the slave side of a pseudoterminal.
+should be called before opening the terminal end of
+a pseudoterminal device pair.
 .SH RETURN VALUE
 When successful,
 .BR unlockpt ()
@@ -55,7 +56,7 @@ argument is not a file descriptor open for writing.
 .B EINVAL
 The
 .I fd
-argument is not associated with a master pseudoterminal.
+argument is not associated with a pseudoterminal device.
 .SH VERSIONS
 .BR unlockpt ()
 is provided in glibc since version 2.1.
diff --git a/man4/pts.4 b/man4/pts.4
index 0b0682433..8897c924a 100644
--- a/man4/pts.4
+++ b/man4/pts.4
@@ -7,50 +7,54 @@
 .\"
 .TH PTS 4 2016-03-15 "Linux" "Linux Programmer's Manual"
 .SH NAME
-ptmx, pts \- pseudoterminal master and slave
+ptmx, pts \- pseudoterminal devices
 .SH DESCRIPTION
 The file
 .I /dev/ptmx
 (the pseudoterminal multiplexor device)
 is a character file with major number 5 and
 minor number 2, usually with mode 0666 and ownership root:root.
-It is used to create a pseudoterminal master and slave pair.
+It is used to create a pseudoterminal device pair.
 .PP
 When a process opens
 .IR /dev/ptmx ,
 it gets a file
-descriptor for a pseudoterminal master
-and a pseudoterminal slave device is created in the
+descriptor for a new pseudoterminal device
+and a corresponding terminal device is created in the
 .I /dev/pts
 directory.
 Each file descriptor obtained by opening
 .IR /dev/ptmx
-is an independent pseudoterminal master with its own associated slave,
+is an independent pseudoterminal device with its own associated terminal device,
 whose path can
 be found by passing the file descriptor to
 .BR ptsname (3).
 .PP
-Before opening the pseudoterminal slave, you must pass the master's file
+Before opening the corresponding terminal device,
+you must pass the pseudoterminal device's file
 descriptor to
 .BR grantpt (3)
 and
 .BR unlockpt (3).
 .PP
-Once both the pseudoterminal master and slave are open, the slave provides
+Once both the pseudoterminal device and the terminal device are open,
+the terminal device provides
 processes with an interface that is identical to that of a real terminal.
 .PP
-Data written to the slave is presented on the master file descriptor as input.
-Data written to the master is presented to the slave as input.
+Data written to the terminal device is presented on
+the pseudoterminal device as input.
+Data written to the pseudoterminal device is presented
+to the terminal device as input.
 .PP
 In practice, pseudoterminals are used for implementing terminal emulators
 such as
 .BR xterm (1),
-in which data read from the pseudoterminal master is interpreted by the
+in which data read from the pseudoterminal device is interpreted by the
 application in the same way
 a real terminal would interpret the data, and for implementing remote-login
 programs such as
 .BR sshd (8),
-in which data read from the pseudoterminal master is sent across the network
+in which data read from the pseudoterminal device is sent across the network
 to a client program that is connected to a terminal or terminal emulator.
 .PP
 Pseudoterminals can also be used to send input to programs that normally
diff --git a/man7/pty.7 b/man7/pty.7
index ecc1a6bec..e8b6c9539 100644
--- a/man7/pty.7
+++ b/man7/pty.7
@@ -26,36 +26,39 @@
 .SH NAME
 pty \- pseudoterminal interfaces
 .SH DESCRIPTION
-A pseudoterminal (sometimes abbreviated "pty")
+A pseudoterminal (sometimes abbreviated "pty") device pair
 is a pair of virtual character devices that
 provide a bidirectional communication channel.
 One end of the channel is called the
-.IR master ;
+.IR "pseudoterminal device" ;
 the other end is called the
-.IR slave .
+.IR "terminal device" .
 .PP
-The slave end of the pseudoterminal provides an interface
+The terminal end of the device pair provides an interface
 that behaves exactly like a classical terminal.
-A process that expects to be connected to a terminal,
-can open the slave end of a pseudoterminal and
-then be driven by a program that has opened the master end.
-Anything that is written on the master end is provided to the process
-on the slave end as though it was input typed on a terminal.
+A process that expects to be connected to a terminal
+can open the terminal end of a pseudoterminal device pair and
+then be driven by a program that has opened the pseudoterminal end
+of the device pair.
+Anything that is written on the pseudoterminal end is provided to the process
+on the terminal end as though it was input typed on a terminal.
 For example, writing the interrupt character (usually control-C)
-to the master device would cause an interrupt signal
+to the pseudoterminal end of the device pair would cause an interrupt signal
 .RB ( SIGINT )
 to be generated for the foreground process group
-that is connected to the slave.
-Conversely, anything that is written to the slave end of the
-pseudoterminal can be read by the process that is connected to
-the master end.
+that is connected to the terminal end.
+Conversely, anything that is written to the terminal end of the
+device pair can be read by the process that is connected to
+the pseudoterminal end.
 .PP
-Data flow between master and slave is handled asynchronously,
+Data flow between the two ends of the device pair is handled asynchronously,
 much like data flow with a physical terminal.
-Data written to the slave will be available at the master promptly,
+Data written to the terminal end will be available at
+the pseudoterminal end promptly,
 but may not be available immediately.
 Similarly, there may be a small processing delay between
-a write to the master, and the effect being visible at the slave.
+a write to the pseudoterminal end,
+and the effect being visible at the terminal end.
 .PP
 Historically, two pseudoterminal APIs have evolved: BSD and System V.
 SUSv1 standardized a pseudoterminal API based on the System V API,
@@ -75,18 +78,18 @@ option.
 that option is disabled by default in the mainline kernel.)
 UNIX 98 pseudoterminals should be used in new applications.
 .SS UNIX 98 pseudoterminals
-An unused UNIX 98 pseudoterminal master is opened by calling
+An unused UNIX 98 pseudoterminal device is opened by calling
 .BR posix_openpt (3).
-(This function opens the master clone device,
+(This function opens the pseudoterminal multiplexor device,
 .IR /dev/ptmx ;
 see
 .BR pts (4).)
 After performing any program-specific initializations,
-changing the ownership and permissions of the slave device using
+changing the ownership and permissions of the terminal device using
 .BR grantpt (3),
-and unlocking the slave using
+and unlocking the terminal using
 .BR unlockpt (3)),
-the corresponding slave device can be opened by passing
+the corresponding terminal device can be opened by passing
 the name returned by
 .BR ptsname (3)
 in a call to
@@ -110,9 +113,9 @@ For further details on these two files, see
 BSD-style pseudoterminals are provided as precreated pairs, with
 names of the form
 .I /dev/ptyXY
-(master) and
+(pseudoterminal) and
 .I /dev/ttyXY
-(slave),
+(corresponding terminal),
 where X is a letter from the 16-character set [p\-za\-e],
 and Y is a letter from the 16-character set [0\-9a\-f].
 (The precise range of letters in these two sets varies across UNIX
@@ -124,22 +127,22 @@ and
 constitute a BSD pseudoterminal pair.
 A process finds an unused pseudoterminal pair by trying to
 .BR open (2)
-each pseudoterminal master until an open succeeds.
-The corresponding pseudoterminal slave (substitute "tty"
-for "pty" in the name of the master) can then be opened.
+each pseudoterminal device until an open succeeds.
+The corresponding terminal device (substitute "tty"
+for "pty" in the name of the pseudoterminal device) can then be opened.
 .SH FILES
 .TP
 .I /dev/ptmx
-UNIX 98 master clone device
+UNIX 98 pseudoterminal multiplexor device
 .TP
 .I /dev/pts/*
-UNIX 98 slave devices
+UNIX 98 terminal devices
 .TP
 .I /dev/pty[p\-za\-e][0\-9a\-f]
-BSD master devices
+The BSD pseudoterminal devices
 .TP
 .I /dev/tty[p\-za\-e][0\-9a\-f]
-BSD slave devices
+The corresponding BSD terminal devices
 .SH NOTES
 Pseudoterminals are used by applications such as network login services
 .RB ( ssh "(1), " rlogin "(1), " telnet (1)),
 
-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

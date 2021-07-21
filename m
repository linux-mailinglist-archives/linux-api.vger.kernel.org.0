Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC13D0953
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 09:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhGUGVM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbhGUGVC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 02:21:02 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E87C061574
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 00:01:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id q10so1494077pfj.12
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4w+j0SwaMOCBb+VbQ/z6mH/2y8ZHdpNrgHHU7GAflIw=;
        b=IImR3Br9yhWegMIsWUn1s4ke5bcgqB1fyuOckJ0362osTV9PLrEfxiMJc0ioiFVJkd
         e1LqJ9seLSf0mz7n1A0zlfQKgx1rrcO3YZdqGcIEWbxSKMHPGkJJBLUG+PiYWLrYTuik
         /Kexavs/CplATzd2LItOHsBBIZtYuGwHJzgnMv8Q3UhRIGiHQ9R3hOEgs5PsLBE3QGiM
         3mYQhuKKTdvquSTL50t4GoiSPoErtgSO30YNwfQZz70kbErIK8voAx/MVqKy8LUaYACD
         YhLJdklahrcJUPZtiKNgKOpB+Nu8vO499c8zPRWt+rwTcCT+XNNz2hxW6ISuWHPj0Va6
         QHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4w+j0SwaMOCBb+VbQ/z6mH/2y8ZHdpNrgHHU7GAflIw=;
        b=qT0SoEGAArl+nIhERajGdNY+pYXs/kG3V4Z5dL7XMErL6yrpyFtL9Qy3QldrtT7/35
         +ECffwxdzLr0dy0ay+e03fI7tFoxaYCcpFoGMTxIDKYehYw6TY9lYUFrZgN5Nvhq6msH
         RE47iRSejy5hmj5GK3XDe1xo3ed7W23ZORCmid4Xz3vXSZjMRL/0LXf+8OS7dkRUmldU
         ot9wnyrbWSFHO0gkTuAWeXJpPHhoSfUeBpNzOYZQdjUgMR5rHDHcmfvDDJkQ+PtqtwWi
         743stRyTJSKNP0MYseDV+GbGQ9XlK1K+WUI4pK1QsqGiNoy0rEE4a88104w7jXuA/Se+
         peog==
X-Gm-Message-State: AOAM530UD34XaZ+xs5U+YhPksSaWyvSXCJAVcM4Hz4l1OOUt6VB+nHzE
        oMEni8bHxU/V5ZMT7Hyw90WaYg==
X-Google-Smtp-Source: ABdhPJyfm9g7smILR0LXObkOvOQKYJvQKi2qb+DNZ3ZO9eHhSN3qE1SW8jHWkT3s8sBA2QAs5coikw==
X-Received: by 2002:a63:1648:: with SMTP id 8mr34463262pgw.140.1626850895177;
        Wed, 21 Jul 2021 00:01:35 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c03c:a42a:c97a:1b7d])
        by smtp.gmail.com with ESMTPSA id o3sm4600702pjr.49.2021.07.21.00.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 00:01:34 -0700 (PDT)
Date:   Wed, 21 Jul 2021 17:01:22 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     krisman@collabora.com
Cc:     amir73il@gmail.com,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Jan Kara <jack@suse.cz>, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] fanotify.7, fanotify_mark.2: Document FAN_FS_ERROR
Message-ID: <YPfGQixNHTo0ZyoS@google.com>
References: <20210720160244.1449197-1-krisman@collabora.com>
 <CAOQ4uxi9o6Vty2s+OXY5yeLDTJ2YMMO5NrAF+vmqOv69pQw0rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi9o6Vty2s+OXY5yeLDTJ2YMMO5NrAF+vmqOv69pQw0rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hey Gabriel,

Sorry, I haven't really been following this series. However, I've just read
through this man-pages patch from the perspective of an API consumer and
sprayed a couple suggestions.

For the next iteration, do you mind CC'ing me?

On Tue, Jul 20, 2021 at 08:47:31PM +0300, Amir Goldstein wrote:
> +linux-api
> 
> On Tue, Jul 20, 2021 at 7:02 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
> >
> > The kernel patches are not merged upstream, so please refrain from merging
> > it at the moment.  This submission attempts to preview the interface
> > and gather some interface review.
> >
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> >
> 
> Looks good as a first draft.
> 
> Thanks,
> Amir.
> 
> > ---
> > To: Michael Kerrisk <mtk.manpages@gmail.com>
> > Cc: linux-man@vger.kernel.org
> > ---
> >  man2/fanotify_mark.2 | 14 +++++++++
> >  man7/fanotify.7      | 72 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+)
> >
> > diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
> > index be3f72e040c0..500e41faa4f0 100644
> > --- a/man2/fanotify_mark.2
> > +++ b/man2/fanotify_mark.2
> > @@ -214,6 +214,20 @@ Create an event when a marked file or directory itself is deleted.
> >  An fanotify group that identifies filesystem objects by file handles
> >  is required.
> >  .TP
> > +.BR FAN_FS_ERROR "(since Linux 5.15)"
> > +.\" commit WIP
> > +Create an event when a file system error is detected.
> > +A fanotify group that identifies filesystem objects by file handles
> > +is required.
> > +Support for this type of notification is done per-file system,
> > +but not every filesystem supports it.
> > +Additional information is submitted in the form of a
> > +.BR FAN_EVENT_INFO_TYPE_ERROR
> > +record.

The term "submitted" sounds confusing in this context, does it not? I think
we traditionally mention that an event listener can expect to receive an
additional information object of type X alongside the generic metadata
event.

> > +See
> > +.BR fanotify (7)
> > +for additional details.
> > +.TP
> >  .BR FAN_MOVED_FROM " (since Linux 5.1)"
> >  .\" commit 235328d1fa4251c6dcb32351219bb553a58838d2
> >  Create an event when a file or directory has been moved from a marked
> > diff --git a/man7/fanotify.7 b/man7/fanotify.7
> > index 6a7e70d75845..155ba8273463 100644
> > --- a/man7/fanotify.7
> > +++ b/man7/fanotify.7
> > @@ -188,6 +188,24 @@ struct fanotify_event_info_fid {
> >  .EE
> >  .in
> >  .PP
> > +In case of a FAN_FS_ERROR event,
> > +besides the file handle record,
> > +an additional record describing the error that occurred
> > +is included in the read buffer.
> > +The structure described below, will follow the generic
> > +.I fanotify_event_metadata
> > +structure within the read buffer:
> > +.PP
> > +.in +4n
> > +.EX
> > +struct fanotify_event_info_error {
> > +    struct fanotify_event_info_header hdr;
> > +    __s32 error;
> > +    __u32 error_count;
> > +};
> > +.EE
> > +.in
> > +.PP
> >  For performance reasons, it is recommended to use a large
> >  buffer size (for example, 4096 bytes),
> >  so that multiple events can be retrieved by a single
> > @@ -311,6 +329,9 @@ A child file or directory was deleted in a watched parent.
> >  .B FAN_DELETE_SELF
> >  A watched file or directory was deleted.
> >  .TP
> > +.B FAN_FS_ERROR
> > +A file-system error was detected.
> > +.TP
> >  .B FAN_MOVED_FROM
> >  A file or directory has been moved from a watched parent directory.
> >  .TP
> > @@ -510,6 +531,32 @@ and the file handle is followed by a null terminated string that identifies the
> >  name of a directory entry in that directory, or '.' to identify the directory
> >  object itself.
> >  .PP
> > +The fields of the
> > +.I fanotify_event_info_error
> > +structure are as follows:
> > +.TP
> > +.I hdr
> > +This is a structure of type
> > +.IR fanotify_event_info_header .
> > +is a generic header that contains information used to

... and is a generic ...

> > +describe an additional information record attached to the event.
> > +For
> > +.IR fanotify_event_info_error ,
> > +.I info_type
> > +will have the value
> > +.BR FAN_EVENT_INFO_TYPE_ERROR .
> > +.I len
> > +has the size of the additional information record including the
> > +.IR fanotify_event_info_header
> > +itself.
> > +.TP
> > +.I error
> > +Identifies the file system specific error that occured
> > +.TP
> > +.I error_count
> > +This counts the number of errors suppressed
> > +since the last error was read.
> > +.PP
> >  The following macros are provided to iterate over a buffer containing
> >  fanotify event metadata returned by a
> >  .BR read (2)
> > @@ -599,6 +646,31 @@ field.
> >  In that case, the audit subsystem will log information about the access
> >  decision to the audit logs.
> >  .\"
> > +.SS Monitoring file systems for error
					  ^ s?
					  
> > +A single FAN_FS_ERROR event is stored by the kernel at once.
> > +Extra error messages are suppressed and accounted
						       ^ for?
> > +inside the current FAN_FS_ERROR event record,
> > +but details about the errors are lost.
> > +.PP
> > +Error types reported by FAN_FS_ERROR are file system specific
> > +and not all kinds of error are reported by all file system.
    	     	       	       ^ s?			       ^ s?

Here, my understanding is that the filesystem errors are distinct across
each of the different filesystems that are capable of generating
FAN_FS_ERROR errors i.e. ext4; therefore filesystem specific documentation
should be consulted in order to get more meta-information about the actual
underlying filesystem error that occurred on the watched object.

Is that correct?

> > +Refer to the file system documentation
> > +for the information of which errors are reported,

... for additional/more information on the type of errors that are
supported/reported, ...?

> > +and the meaning of those errors.
> > +.PP
> > +Errors not directly related to a file (i.e. super block corruption)
> > +are reported with an invalid file handler.
    	 	       	  	  ^
.I file_handle .

> > +For these errors,
> > +.I file_handle

For such errors, the
.I file_handle
will have the field... 

> > +will have the field
> > +.I handle_type
> > +set to
> > +.BR FILEID_INVALID ,
> > +and the
> > +.I f_handle
> > +buffer set to
> > +.BR 0 .
> > +.\"
> >  .SS Closing the fanotify file descriptor
> >  When all file descriptors referring to the fanotify notification group are
> >  closed, the fanotify group is released and its resources
> > --
> > 2.32.0
> >

/M

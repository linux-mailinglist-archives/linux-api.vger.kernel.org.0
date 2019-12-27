Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0312B44B
	for <lists+linux-api@lfdr.de>; Fri, 27 Dec 2019 12:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfL0Lrb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Dec 2019 06:47:31 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:46419 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfL0Lrb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 06:47:31 -0500
Received: from p5b2a6dac.dip0.t-ipconnect.de ([91.42.109.172] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iko5X-0006iS-El; Fri, 27 Dec 2019 11:47:27 +0000
Date:   Fri, 27 Dec 2019 12:47:26 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        keescook@chromium.org
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
Message-ID: <20191227114725.xsacnaoaaxdv6yg3@wittgenstein>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal>
 <20191226115245.usf7z5dkui7ndp4w@wittgenstein>
 <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
 <57C06925-0CC6-4251-AD57-8FF1BC28F049@ubuntu.com>
 <20191227022446.37e64ag4uaqms2w4@yavin.dot.cyphar.com>
 <20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191227023131.klnobtlfgeqcmvbb@yavin.dot.cyphar.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Dec 27, 2019 at 01:31:31PM +1100, Aleksa Sarai wrote:
> On 2019-12-27, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2019-12-26, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > On December 26, 2019 3:32:29 PM GMT+01:00, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > >On 2019-12-26, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > > >> On Wed, Dec 25, 2019 at 09:45:33PM +0000, Sargun Dhillon wrote:
> > > >> > This patch is a small change in enforcement of the uapi for
> > > >> > SECCOMP_IOCTL_NOTIF_RECV ioctl. Specificaly, the datastructure
> > > >which is
> > > >> > passed (seccomp_notif), has a flags member. Previously that could
> > > >be
> > > >> > set to a nonsense value, and we would ignore it. This ensures that
> > > >> > no flags are set.
> > > >> > 
> > > >> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> > > >> > Cc: Kees Cook <keescook@chromium.org>
> > > >> 
> > > >> I'm fine with this since we soon want to make use of the flag
> > > >argument
> > > >> when we add a flag to get a pidfd from the seccomp notifier on
> > > >receive.
> > > >> The major users I could identify already pass in seccomp_notif with
> > > >all
> > > >> fields set to 0. If we really break users we can always revert; this
> > > >> seems very unlikely to me though.
> > > >> 
> > > >> One more question below, otherwise:
> > > >> 
> > > >> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
> > > >> 
> > > >> > ---
> > > >> >  kernel/seccomp.c | 7 +++++++
> > > >> >  1 file changed, 7 insertions(+)
> > > >> > 
> > > >> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > >> > index 12d2227e5786..455925557490 100644
> > > >> > --- a/kernel/seccomp.c
> > > >> > +++ b/kernel/seccomp.c
> > > >> > @@ -1026,6 +1026,13 @@ static long seccomp_notify_recv(struct
> > > >seccomp_filter *filter,
> > > >> >  	struct seccomp_notif unotif;
> > > >> >  	ssize_t ret;
> > > >> >  
> > > >> > +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
> > > >> > +		return -EFAULT;
> > > >> > +
> > > >> > +	/* flags is reserved right now, make sure it's unset */
> > > >> > +	if (unotif.flags)
> > > >> > +		return -EINVAL;
> > > >> > +
> > > >> 
> > > >> Might it make sense to use
> > > >> 
> > > >> 	err = copy_struct_from_user(&unotif, sizeof(unotif), buf,
> > > >sizeof(unotif));
> > > >> 	if (err)
> > > >> 		return err;
> > > >> 
> > > >> This way we check that the whole struct is 0 and report an error as
> > > >soon
> > > >> as one of the members is non-zero. That's more drastic but it'd
> > > >ensure
> > > >> that other fields can be used in the future for whatever purposes.
> > > >> It would also let us get rid of the memset() below. 
> > > >
> > > >Given that this isn't an extensible struct, it would be simpler to just
> > > >do
> > > >check_zeroed_user() -- copy_struct_from_user() is overkill. That would
> > > >also remove the need for any copy_from_user()s and the memset can be
> > > >dropped by just doing
> > > >
> > > >  struct seccomp_notif unotif = {};
> > > >
> > > >> >  	memset(&unotif, 0, sizeof(unotif));
> > > >> >  
> > > >> >  	ret = down_interruptible(&filter->notif->request);
> > > >> > -- 
> > > >> > 2.20.1
> > > >> > 
> > > 
> > > It is an extensible struct. That's why we have notifier size checking built in.
> > 
> > Ah right, NOTIF_GET_SIZES. I reckon check_zeroed_user() is still a bit
> > simpler since none of the fields are used right now (and really, this
> > patch should be checking all of them, not just ->flags, if we want to
> > use any of them in the future).
> 
> Scratch that -- as Tycho just mentioned, there is un-named padding in
> the struct so check_zeroed_user() is the wrong thing to do. But this

Hm, I don't think so.
I understood Tycho's point as _if_ there ever is padding then this would
not be zeroed.
Right now, there is no padding since the struct is correctly padded:

struct seccomp_data {
	int nr;
	__u32 arch;
	__u64 instruction_pointer;
	__u64 args[6];
};

struct seccomp_notif {
	__u64 id;
	__u32 pid;
	__u32 flags;
	struct seccomp_data data;
};

which would be - using pahole:

struct seccomp_data {
        int                        nr;                   /*     0     4 */
        __u32                      arch;                 /*     4     4 */
        __u64                      instruction_pointer;  /*     8     8 */
        __u64                      args[6];              /*    16    48 */

        /* size: 64, cachelines: 1, members: 4 */
};
struct seccomp_notif {
        __u64                      id;                   /*     0     8 */
        __u32                      pid;                  /*     8     4 */
        __u32                      flags;                /*    12     4 */
        struct seccomp_data data;                        /*    16    64 */

        /* size: 80, cachelines: 2, members: 4 */
        /* last cacheline: 16 bytes */
};

The only worry would be a 2byte int type but there's no architecture
we support which does this right now afaict.

> also will make extensions harder to deal with because (presumably) they
> will also have un-named padding, making copy_struct_from_user() the

This all will be a non-issue if we just use __u64 for extensions.

My point about using copy_struct_from_user() was that we should verify
that _all_ fields are uninitialized and not just the flags argument
since we might introduce a flags argument that requires another already
existing member in seccomp_notif to be set to a value. We should do this
change now so we don't have to risk breaking someone in the future.

I'm trying to get at least Mozilla/Firefox off of their crazy
SECCOMP_RET_TRAP way of implementing their broker onto the user notifier
and they will likely need some extensions. That includes the pidfd stuff
for seccomp that Sargun will likely be doing and the new pidfd_getfd()
syscall. So it's not unlikely that we might need other already existing
fields in that struct to be set to some value.

I don't particulary care how we do it:
- We can do a simple copy_from_user() and check each field individually.
- Use copy_struct_from_user().
  That is safe to do right now since there is no padding afaict and
  it'll automatically verify new fields as well.
  If I understand the worry correctly then the argument against
  copy_struct_from_user() here is that there might be padding introduced
  and userspace will not do an explicit memset() but rather rely on an
  empty inializer {} and will _accidently_ pass down a struct which has
  __all fields cleared__ but __uninitialized padding__ and we tell them
  EINVAL? That can only happen if we introduce padding in the struct
  which I'd argue we just don't do. That'll be in line with what we
  require from our ABIs already anyway.

Christian
